let submit_messages;

$(document).on('turbolinks:load', function () {
  submit_messages()

  App.cable.subscriptions.create({
    channel: "MessagesChannel",
    room_id: $('#messages').attr('data-chatroom')
  }, {
      connected() {
        // Called when the subscription is ready for use on the server
      },
  
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
  
      received: function(data) {
        $("[data-chatroom='" + data.chatroom + "']").removeClass('hidden')
        return $("[data-chatroom='" + data.chatroom+ "']").append(this.renderMessage(data));
      },

      renderMessage: function(data) {
        let div = "";
        if (data.reciever_id.toString() === current_user_id){
          div = `<div tabindex="-1" class="_2hqOq message-out focusable-list-item" data-id="true_923338727370@c.us_3EB0438F717F9E1E971D"><span></span>
                  <div class="_2et95 _3c94e _1dvTE"><span data-testid="tail-out" data-icon="tail-out" class="_2-dPL"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 8 13" width="8" height="13"><path opacity=".13" d="M5.188 1H0v11.193l6.467-8.625C7.526 2.156 6.958 1 5.188 1z"></path><path fill="currentColor" d="M5.188 0H0v11.193l6.467-8.625C7.526 1.156 6.958 0 5.188 0z"></path></svg></span>
                    <div class="_3sKvP wQZ0F"><span aria-label="You:"></span>
                      <div class="_274yw">
                        <div class="copyable-text">
                          <div class="eRacY" dir="ltr"><span dir="ltr" class="_3Whw5 selectable-text invisible-space copyable-text"><span><strong>${data.user.username}: </strong>${data.message}</span></span><span class="_2oWZe _2HWXK"></span></div>
                        </div>
                      </div><span></span></div>
                  </div>
                </div>`
        }
        else{
          div = `<div tabindex="-1" class="_2hqOq message-in focusable-list-item" data-id="false_923338727370@c.us_2A295CD64FE18D4BC5A841BABAFBC202"><span></span>
                  <div class="_2et95 _3c94e _1dvTE">
                    <span data-testid="tail-in" data-icon="tail-in" class="_2-dPL">
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 8 13" width="8" height="13">
                        <path opacity=".13" fill="#0000000" d="M1.533 3.568L8 12.193V1H2.812C1.042 1 .474 2.156 1.533 3.568z"></path>
                        <path fill="currentColor" d="M1.533 2.568L8 11.193V0H2.812C1.042 0 .474 1.156 1.533 2.568z"></path>
                      </svg>
                    </span>
              
                    <div class="_3sKvP wQZ0F"><span aria-label=""></span>
                      <div class="_274yw">
                        <div class="copyable-text">
                          <div class="eRacY" dir="ltr"><span dir="ltr" class="_3Whw5 selectable-text invisible-space copyable-text"> <span><strong>${data.user.username}: </strong>${data.message}</span></span><span class="_2oWZe"></span></div>
                        </div>
                      </div>
                      <span></span>
                    </div>
                  </div>
                </div>`
        }
        return div;
      }
    });

})

submit_messages = function () {
  $('textarea#message_content').keydown(function(event) {
    if (event.keyCode == 13) {
        $('[data-send="message"]').click();
        $('[data-textarea="message"]').val(" ");
        return false;
     }
  });
}