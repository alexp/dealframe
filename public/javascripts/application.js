// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script; 
  $('.data').ajaxStart(function(){
    $(this).html("<p><img src='/images/loader.gif' border='0' align='center' style='width: 16px; height: 16px;' /></p>");
  });

  $('#follow_form').ajaxStart(function(){
    $("span.liloader").css("display", "inline");
  });
  
  $('.deals').click(function() {
    
    var panel = $('.panel');
    panel.fadeIn();
    $('#panel-frame').css("display", "block");

    $('.data').empty(); 
    
    if(panel.css('left') == "592px") {
    
    } else {
      panel.animate({
        left: parseInt(panel.css('left'),0) == 0 ? +panel.outerWidth()+290 : 0
      });
    }

    $.ajax({
      url: "/offers/"+this.id.split("-")[1],
      type: "get",
      success: function(data) {
        $(".data").html(data);
      },
      dataType: "html"
    });
  });
  
  $('.deals').mouseenter(function() {
    $('.check.'+this.id).show();
  });

  $('.deals').mouseleave(function() {
    $('.check.'+this.id).hide();
  });

  $('.close').click(function() {
    var panel= $('.panel');
    panel.animate({left: parseInt(panel.css('left'),0) == 0 ? +panel.outerWidth() : 0});
    panel.fadeOut();
    return false;
  }); 
  

  $('#promoted').click(function() {
    
    $('#deallist').ajaxStart(function(){
      $("#deallist").html("<div style='width: 220px; margin: auto; padding-top: 50px;'><img src='/images/big_loader.gif' border='0' align='center' style='width: 220px; height: 19px;' /></div>");
    });
      
    if(!$(this).hasClass("active")) {
      $.ajax({
        url: "/offers?tag[]=Promowane&tag[]=Dla kobiet",
        type: "get",
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#promoted").addClass("active");
        },
        dataType: "html"
      });
    } else {
      $.ajax({
        url: "/offers",
        type: "get",
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#promoted").removeClass("active");
        },
        dataType: "html"
      });
    }
  });


  $('#for_kids').click(function() {

    $('#deallist').ajaxStart(function(){
      $("#deallist").html("<div style='width: 220px; margin: auto; padding-top: 50px;'><img src='/images/big_loader.gif' border='0' align='center' style='width: 220px; height: 19px;' /></div>");
    });

    if(!$(this).hasClass("active")) {
      $.ajax({
        url: "/offers?tag[]=Dla dzieci",
        type: "get",
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_kids").addClass("active");
        },
        dataType: "html"
      });
    } else {
      $.ajax({
        url: "/offers",
        type: "get",
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_kids").removeClass("active");
        },
        dataType: "html"
      });
    }
  });
  
  // ajax na kategoriach
  //$('#categories a').click(function() {
  //  
  //  $('#deallist').ajaxStart(function(){
  //    $("#deallist").html("<div style='width: 220px; margin: auto; padding-top: 50px;'><img src='/images/big_loader.gif' border='0' align='center' style='width: 220px; height: 19px;' /></div>");
  //  });

  //  $("#deallist").ajaxComplete(function(e, xhr, settings){
  //      $("#deallist").empty();  
        //$("#deallist").html(xhr.responseHTML);
  //      alert(xhr.responseHTML);
  //  });

  //});
  
  $('#category_id').change(function() {
    var category_id = $('#category_id option:selected').val()

    $('#deallist').ajaxStart(function(){
      $("#deallist").html("<div style='width: 220px; margin: auto; padding-top: 50px;'><img src='/images/big_loader.gif' border='0' align='center' style='width: 220px; height: 19px;' /></div>");
    });
    //TODO: refactor
    //var current_location = window.location.href;

    //if(current_location.indexOf("/#!/categories/") != -1) {
    //  window.location.href = current_location.split("#!")[0] + "#!/categories/"+category_id;
    //} else {
    //  window.location.href = current_location + "/#!/categories/"+category_id;
    //}

    
    $.ajax({
      url: "/categories/"+category_id,
      type: "get",
      success: function(data) {
        $("#deallist").empty();
        $("#deallist").html(data);
        $("#categories a").removeClass("active");
        $("#categories a").find("span").removeClass("active");
        $("#categories a[href$='/categories/"+category_id+"']").addClass("active");
        $("#categories a[href$='/categories/"+category_id+"']").find("span").addClass("active");
      },
      dataType: "html"
    });
  });
});
