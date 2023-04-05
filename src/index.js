
async function incrementUserCount() {
    const response = await fetch("https://vrvf5mlej7.execute-api.us-east-1.amazonaws.com/test", {
        method: "PUT",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
        },
    });
    const jsonData = await response.json();
    const userCount = document.querySelector('.userCount');
    userCount.innerHTML = jsonData.body.userCount;
    console.log(jsonData);

  }


window.onload = function() {
    incrementUserCount()
}
