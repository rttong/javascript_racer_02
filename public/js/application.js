var update_player_position = function(player_id) {
  var nextChild = ($(player_id + ' .active').index() + 2);
  var nextSquare = $(player_id + ' td:nth-child(' + nextChild + ')');
  $(player_id + ' .active').removeClass('active');
  $(nextSquare).addClass('active');
};

var finished = function() {
  if( $('#player1_strip td:last-child').hasClass('active') ) {
    return true;
  }
  else if ( $('#player2_strip td:last-child').hasClass('active') ) {
    return true;
  }
  else {
    return false;
  }
};

var winner = function() {
  if( $('#player1_strip td:last-child').hasClass('active') ) {
    return 'player1';
  }
  else if ( $('#player2_strip td:last-child').hasClass('active') ) {
    return 'player2';
  }
};


$(document).ready(function() {
  
  var startTime = Date.now();
  $(document).on('keyup', function(event) {
   if ( finished() === true ) {
    var endTime = Date.now();
    var gameId = $('#game_id').text();
    var timeElapsed = endTime - startTime;
    var result = winner();
    $.ajax({
      type: "POST",
      url: '/gameplay',
      data: {time: timeElapsed, winner: result, current_game: gameId}
    }).done(function(response) {
      $('body').replaceWith(response);
    });
   }
   else if (event.which === 81) {
    update_player_position('#player1_strip');

   }
   else if (event.which === 80) {
    update_player_position('#player2_strip');
   }

  });
});

