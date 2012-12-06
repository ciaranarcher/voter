// namespace
var Voter = Voter || {};

// entry point
$(document).ready(function() {
  // create document
  Voter.myDOMHelper = new Voter.DOMHelper();
  Voter.myDOMHelper.handleVoteSubmissions();
});

// create object
Voter.DOMHelper = function() {};

// attch buttons for clicking a vote
Voter.DOMHelper.prototype.handleVoteSubmissions = function() {
  
  $('#vote-options input').click(function () {
    var option = $(this).attr('data-value');
    var participant_name = $('#participant-name').text();
    var participant_email = $('#participant-email').text();
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
          if (resp.success) {
          $('#modal-label').text('Success!');
          $('#modal-txt').text('Your vote has been recorded. Thanks!');
        } else {
          $('#modal-label').text('Oops!');
          if (resp.reason == 'voted before') {
            $('#modal-txt').text('You\'ve already voted on this topic.');
          } else {
            $('#modal-txt').text('Something strange just happened. Please try again.');
          }
        }

        $('#vote-modal').modal({});
      });
  });
};