// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script; 
  //$('.data').ajaxStart(function(){
  //  $(this).html("<p><img src='/images/loader.gif' border='0' align='center' style='width: 16px; height: 16px;' /></p>");
  //});

  $('#follow_form').ajaxStart(function(){
    $("span.liloader").css("display", "inline");
  });
  
  show_offer_register(); 

  $('#promoted').click(function() {
    if(!$(this).hasClass("active")) {
      $.ajax({
        url: "/offers?tag[]=Promowane&tag[]=Dla kobiet",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#promoted").addClass("active");
          show_offer_register();
        },
        dataType: "html"
      });
    } else {
      $.ajax({
        url: "/offers",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#promoted").removeClass("active");
          show_offer_register();
        },
        dataType: "html"
      });
    }
  });


  $('#for_kids').click(function() {
    if(!$(this).hasClass("active")) {
      $.ajax({
        url: "/offers?tag[]=Dla dzieci",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_kids").addClass("active");
          show_offer_register();
        },
        dataType: "html"
      });
    } else {
      $.ajax({
        url: "/offers",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_kids").removeClass("active");
          show_offer_register(); 
        },
        dataType: "html"
      });
    }
  });
  
  $('#for_women').click(function() {
    if(!$(this).hasClass("active")) {
      $.ajax({
        url: "/offers?tag[]=Dla kobiet",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_women").addClass("active");
          show_offer_register(); 
        },
        dataType: "html"
      });
    } else {
      $.ajax({
        url: "/offers",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_women").removeClass("active");
          show_offer_register(); 
        },
        dataType: "html"
      });
    }
  });
  
  $('#for_men').click(function() {
    if(!$(this).hasClass("active")) {
      $.ajax({
        url: "/offers?tag[]=Dla mężczyzn",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_men").addClass("active");
          show_offer_register(); 
        },
        dataType: "html"
      });
    } else {
      $.ajax({
        url: "/offers",
        type: "get",
        beforeSend: show_offers_loader(),
        success: function(data) {
          $("#deallist").empty();
          $("#deallist").html(data);
          $("#for_men").removeClass("active");
          show_offer_register(); 
        },
        dataType: "html"
      });
    }
  });
  $('#category_id').change(function() {
    var category_id = $('#category_id option:selected').val()

    $.ajax({
      url: "/categories/"+category_id,
      type: "get",
      beforeSend: show_offers_loader(),
      success: function(data) {
        $("#deallist").empty();
        $("#deallist").html(data);
        $("#categories a").removeClass("active");
        $("#categories a").find("span").removeClass("active");
        $("#categories a[href$='/categories/"+category_id+"']").addClass("active");
        $("#categories a[href$='/categories/"+category_id+"']").find("span").addClass("active");
          show_offer_register(); 
      },
      dataType: "html"
    });
  });
});

function show_offer_register() {
    $('.deals').click(function() {
      
      var panel = $('.panel');
      panel.fadeIn();
      $('#panel-frame').css("display", "block");

      $('.data').empty(); 
      
      if(panel.css('left') == "601px") {
      } else {
        panel.animate({
          left: parseInt(panel.css('left'),0) == 0 ? +panel.outerWidth()+290 : 0
        });
      }

      $.ajax({
        url: "/offers/"+this.id.split("-")[1],
        type: "get",
        beforeSend: function() {
          $(".data").html("<p><img src='/images/loader.gif' border='0' align='center' style='width: 16px; height: 16px;' /></p>");
        },
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
}

function show_offers_loader() {
  $("#deallist").html("<div style='width: 220px; margin: auto; padding-top: 50px;'><img src='/images/big_loader.gif' border='0' align='center' style='width: 220px; height: 19px;' /></div>");
}
