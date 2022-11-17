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
      $("#new_message").append("<h3 class='msg-left-sub msg-desc'>" + data.current_user + ":- " + data.message.m_body + "</h3>");
      
    }
  });
});