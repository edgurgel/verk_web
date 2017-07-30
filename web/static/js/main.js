import PageIndex from "./page_index"
import QueuesIndex from "./queues_index"

const views = {
  PageIndex, QueuesIndex
}

function handleDOMContentLoaded() {
  const viewName = document.getElementsByTagName('body')[0].dataset.jsViewPath;

  views[viewName].init();
}

window.addEventListener('DOMContentLoaded', handleDOMContentLoaded, false);
