ready = function(){
    $(".next_step").click(function(e){
        e.preventDefault();
        var parent = $(this).parents(".step")
        parent.hide();
        parent.next().show();

    })
};

$(document).ready(ready);
$(document).on('page:load', ready);