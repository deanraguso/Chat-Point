import consumer from "./consumer"

let url = window.location.href

function create_message(content){
  let div = document.createElement("div");
  let user = gon.users.filter(user => user.id === content.user_id)[0]

  div.innerHTML = `${user.name}: ${content.content} `; 
  if (user.id === gon.current_user.id){
    div.innerHTML += `<a rel="nofollow" data-method="delete" href="/messages/${content.id}">delete</a>`
  }
  return div;
}

if(url.indexOf("rooms") != -1){

  let room_id = parseInt(url.substring(url.search("rooms/") + 6));

  consumer.subscriptions.create({"channel":"RoomChannel", "room_id":room_id}, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log(`connected to room ${room_id}`);
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      document.querySelector("div#messages").insertAdjacentElement("beforeend", create_message(data));
    }
  });
}