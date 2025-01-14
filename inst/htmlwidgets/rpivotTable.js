HTMLWidgets.widget({
    name: 'rpivotTable',
    type: 'output',
    initialize: function(el, width, height) {
	    return {};
    },
    resize: function(el, width, height, instance) { },

    renderValue: function(el, x, instance) {
	    x.data = HTMLWidgets.dataframeToD3(x.data);

      if (typeof x.params.sorters != "undefined") {
        if (typeof x.params.sorters[0] == "string") { // why? this seems odd
            x.params.sorters = eval("("+x.params.sorters[0]+")");
          }
      }
      
      if (typeof x.params.onRefresh != "undefined") {
        x.params.onRefresh = x.params.onRefresh[0];
      }

      var locale = $.pivotUtilities.locales[x.locale];
      locale.renderers = $.extend({}, locale.renderers,
        locale.d3_renderers || $.pivotUtilities.d3_renderers,
        locale.c3_renderers || $.pivotUtilities.c3_renderers);

      // if subtotals then override renderers to add subtotals
      if(x.subtotals) {
        x.params.renderers = $.extend(
          $.pivotUtilities.subtotal_renderers, 
          $.pivotUtilities.renderers,
          $.pivotUtilities.d3_renderers, $.pivotUtilities.c3_renderers
        );
        x.params.dataClass = $.pivotUtilities.SubtotalPivotData;
      }

      if(x.tsv && x.subtotals) { // put tsv first in function so other renderers have priority on the duplicates
        x.params.renderers = $.extend(
          $.pivotUtilities.export_renderers, x.params.renderers
        );
      } else if (x.tsv && !x.subtotals) {
        x.params.renderers = $.extend(
          $.pivotUtilities.export_renderers, $.pivotUtilities.renderers, 
          $.pivotUtilities.d3_renderers, $.pivotUtilities.c3_renderers
        );
      }
      $('#'+el.id).pivotUI(x.data, x.params, true, x.locale);
    }
});
