
async function incrementUserCount() {
    const response = await fetch("https://5kfjc0yuzg.execute-api.us-east-1.amazonaws.com/prod/cloudresume", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
    });
    const jsonData = await response.json();
    const userCount = document.querySelector('.userCount');
    userCount.innerHTML = jsonData.userCount;
    console.log(jsonData);

  }


window.onload = function() {
    incrementUserCount()
}
