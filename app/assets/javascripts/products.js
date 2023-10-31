jQuery(document).ready(function () {
  $("#product-datatable").DataTable({
    processing: true,
    serverSide: true,
    ajax: {
      url: $("#product-datatable").data("source"),
    },
    columns: [{ data: "name" }, { data: "description" }, { data: "price" }],
  });
});
