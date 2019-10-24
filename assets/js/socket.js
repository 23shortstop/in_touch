import {Socket} from "phoenix"

if (typeof window.currentUserId !== 'undefined') {
  let socket = new Socket("/socket", {params: {token: window.userToken}})

  socket.connect()

  let channel = socket.channel("user:" + window.currentUserId, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
};

export default socket
