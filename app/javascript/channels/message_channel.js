import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const group_id = document.getElementById("group_id").value;
  // debugger;
  consumer.subscriptions.create({channel: "MessageChannel", group_id: group_id}, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Channel Connected!!!");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log(data)
      var g_id = data.message.group_id
      var currentUser = $(".body-section").attr("data-current");
      var className = ((parseInt(currentUser) == parseInt(data.message.sender_id)) ? "msg-right" : "msg-left")
      var mainData = "<div class='msg-left-sub msg-desc'><div><h5>"+data.message.m_body+"<br><span style='float:right;'> :-"+data.current_user+"</span><br></h5></div></div>"
      
      $(".chat-template.group-" + g_id + " ul").append("<li class="+className+">"+mainData+"</li>");
      // $("#new_message").append("<h3 class='msg-left-sub msg-desc'>" + data.current_user + ":- " + data.message.m_body + "</h3>");
      
    }
  });
});