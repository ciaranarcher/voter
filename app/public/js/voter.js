// namespace
var Voter = Voter || {};

// entry point
$(document).ready(function() {
  // create document
  Voter.myDOMHelper = new Voter.DOMHelper();
  Voter.myDOMHelper.handleVoteSubmissions();
  Voter.myDOMHelper.handleAdditionalOptions();
});

// create object
Voter.DOMHelper = function() {};

Voter.DOMHelper.prototype.handleAdditionalOptions = function() {

  $('#addAdditionalTopic').click(function() {
    var options = $('#topicFrm div.opt');
    var nextNum = options.length + 1;

    options.last().after('<div class="opt" style="display:none;"><label for="option' 
      + nextNum + '">Option ' 
      + nextNum + '</label><input type="text" id="option' 
      + nextNum + '" name="option' 
      + nextNum + '" /></div>');

    $('#option' + nextNum).parent().show('fast');
  });

};

// attach buttons for clicking a vote
Voter.DOMHelper.prototype.handleVoteSubmissions = function() {
  
  $('#vote-options input').click(function () {
    var option = $(this).attr('data-value');
    var participant_name = $('#participant-name').text();
    var participant_email = $('#participant-email').text();
    var topic_key = $('#topic').attr('data-key');

    $('#vote-modal').on('hidden', function () {
      if ($('#modal-txt').hasClass('success')) {
        window.location.replace('/voted/' + topic_key);
      }
    })
    
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
          $('#modal-txt').removeClass('err').addClass('success').text('Your vote has been recorded. Thanks!');;
        } else {
          $('#modal-label').text('Oops!');
          $('#modal-txt').removeClass('success').addClass('err');
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