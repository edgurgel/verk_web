import {Socket, LongPoller} from "phoenix"
import Rickshaw from "rickshaw"

class App {
  static init(){
    let socket = new Socket("/socket", {
      logger: ((kind, msg, data) => { console.log(`${kind}: ${msg}`, data) })
    })

    let graph = new Rickshaw.Graph({
      element: document.querySelector("#graph"),
      renderer: 'area',
      stroke: true,
      series: new Rickshaw.Series.FixedDuration([{
        name: 'finished', color: 'steelblue'
      },
      {
        name: 'failed', color: 'lightcoral'
      }], undefined, {
        timeInterval: 1000,
        maxDataPoints: 120,
        timeBase: new Date().getTime() / 1000
      })
    })

    var hoverDetail = new Rickshaw.Graph.HoverDetail( {
      graph: graph,
      xFormatter: function(x) {
        return new Date(x * 1000).toString()
      },
      yFormatter: function(y) {
        return parseInt(y)
      }
    })

    socket.connect()

    var chan = socket.channel("rooms:jobs", {})
    chan.join().receive("ignore", () => console.log("auth error"))
               .receive("ok", () => console.log("join ok"))
    chan.onError(e => console.log("something went wrong", e))
    chan.onClose(e => console.log("channel closed", e))

    chan.on("job:stats", msg => {
      graph.series.addData(msg)
      graph.render()
    })
  }
}

$( () => App.init() )

export default App
