const datalistBinding = new Shiny.InputBinding();

$.extend(datalistBinding, {
  find: function (scope) {
    return $(scope).find('.datalist');
  },
  getValue: function(el) {
    const input = el.querySelector('input');
    return input.value || null;
  },
  subscribe: function(el, callback) {
    const input = el.querySelector('input');
    input.addEventListener('change', function(event) {
      callback();
    });
  },
});

Shiny.inputBindings.register(datalistBinding);
