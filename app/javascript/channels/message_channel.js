import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const group_id = document.getElementById("group_id")?.value;
  consumer.subscriptions.create({channel: "MessageChannel", group_id: group_id}, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Channel Connected!!!");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data);
      if (data.message) {
        var g_id = data.message.group_id;
        var currentUser = $(".body-section").attr("data-current");
        var className = ((parseInt(currentUser) == parseInt(data.message.sender_id)) ? "msg-right" : "msg-left");
        var mainData = "<div class='msg-left-sub msg-desc'><div><h5>"+data.message.m_body+"<br><span style='float:right;'> :-"+data.current_user+"</span><br></h5></div></div>";
        
        $(".chat-template.group-" + g_id + " ul").append("<li class="+className+">"+mainData+"</li>");
      } else if (data.html) {
        // Handle HTML content directly or based on your application logic
        $(".chat-tesdmplate").append(data.html);
      } else {
        console.error("Received message data does not contain 'message' or 'html' property:", data);
      }
    }
  });
});