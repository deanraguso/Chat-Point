document.querySelector("input[name='commit']").addEventListener("click", (e)=> {
    setTimeout(()=>{
        document.querySelector("#message_content").value = "";
        document.querySelector("input[name='commit']").disabled = false;
    }, 100);
});