import PageIndex from "./page_index"

const views = {
  PageIndex
}

function handleDOMContentLoaded() {
  const viewName = document.getElementsByTagName('body')[0].dataset.jsViewPath;

  views[viewName].init();
}

window.addEventListener('DOMContentLoaded', handleDOMContentLoaded, false);
