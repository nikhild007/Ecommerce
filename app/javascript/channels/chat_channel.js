import consumer from "channels/consumer";

const App = {};

document.addEventListener("DOMContentLoaded", () => {
  App.cable = consumer.subscriptions.create("ChatChannel", {
    connected() {
      console.log("Connected to ChatChannel");
    },
    received(data) {
      console.log("Received:", data);
      // Handle received data as needed
    },
    disconnected() {
      console.log("Disconnected from ChatChannel");
    },
  });
});

export default App;
