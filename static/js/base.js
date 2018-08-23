function getids() {
    var check_array = [];
    $(".gradeX input:checked").each(function () {
        var id = $(this).attr("value");
        check_array.push(id);
    });
    return check_array.join(",");
}

//此函数用于checkbox的全选和反选

var checked=false;
function check_all(form) {
    var checkboxes = document.getElementById(form);
    if (checked == false) {
        checked = true
    } else {
        checked = false
    }
    for (var i = 0; i < checkboxes.elements.length; i++) {
        if (checkboxes.elements[i].type == "checkbox") {
            checkboxes.elements[i].checked = checked;
        }
    }
}