$(document).on('shiny:inputchanged', function(event) {
  if (event.name != 'changed') {
    Shiny.setInputValue('changed', event.name);
  }
})
