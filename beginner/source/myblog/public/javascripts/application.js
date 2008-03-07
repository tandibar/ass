// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function resetTextValue(id, txt){if($(id).value==txt){$(id).value = "";}}

function show_activity_indicator(){
  $('search-activity-indicator').style.display = "inline"
}

function hide_activity_indicator(request){
  $('search-activity-indicator').style.display = "none"
}