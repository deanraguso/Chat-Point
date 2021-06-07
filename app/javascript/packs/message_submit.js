document.querySelectorAll("input[name='commit']")[1].addEventListener("click", (e)=> {
    setTimeout(()=>{
        document.querySelector("#message_content").value = "";
        document.querySelectorAll("input[name='commit']")[1].disabled = false;
    }, 100);
});