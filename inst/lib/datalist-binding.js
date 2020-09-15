const datalistBinding = new Shiny.InputBinding();

Object.assign(datalistBinding, {
  find(scope) {
    const matches = scope.querySelectorAll('.datalist');
    return matches;
  },
  initialize(el) {
    let options;
    try {
      options = JSON.parse(el.dataset.options);
      this._fillDatalist(el, options);
    } catch (error) {
      options = [];
    }
  },
  getValue(el) {
    const input = el.querySelector('input');
    return input.value;
  },
  subscribe(el, callback) {
    const input = el.querySelector('input');
    input.addEventListener('change', function (event) {
      callback();
    });
  },
  _fillDatalist(el, options) {
    const datalist = el.querySelector('datalist');
    const opts = this._createOptions(options);
    // Clear datalist children
    datalist.textContent = '';
    // Fill with new options
    datalist.append(...opts);
  },
  _createOptions(options) {
    const opts = options.map((option) => {
      const el = document.createElement('option');
      el.setAttribute('value', option);
      return el;
    });
    return opts;
  },
});

Shiny.inputBindings.register(datalistBinding);
