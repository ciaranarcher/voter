// namespace
var Voter = Voter || {};

// entry point
$(document).ready(function() {
  // create document
  Voter.myDOMHelper = new Voter.DOMHelper();
  Voter.myDOMHelper.attachVoteButtons();
});

// create object
Voter.DOMHelper = function() {};

// attch buttons for clicking a vote
Voter.DOMHelper.prototype.attachVoteButtons = function() {
  
  $('#options li').click(function () {
    var option = $(this).text();
    var participant_name = $('#participant_name').text();
    var participant_email = $('#participant_email').text();
    var topic_key = $('#topic').attr('data-key');
    
    // call back to the mothership to say it was voted on
    $.post('/vote', 
      {
        topic_key: topic_key,
        option: option, 
        participant_name: participant_name, 
        participant_email: participant_email
      }, 
      function(resp) {
        console.log(resp);
      });
  });
};