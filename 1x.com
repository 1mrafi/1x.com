<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<title>1XDP.COM | Trusted Agent Portal</title>

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@400;600;700&display=swap" rel="stylesheet" />

<style>
body {
    font-family: 'Hind Siliguri', sans-serif;
    background: #020617;
    color: #fff;
    min-height: 100vh;
    padding: 20px;
}
.glass-card{
    background: rgba(255,255,255,0.03);
    border-radius: 25px;
}
.input-style{
    background:#000;
    border:1px solid #333;
    border-radius:15px;
}
.active-tab{
    background:linear-gradient(135deg,#0891b2,#2563eb);
}
</style>
</head>

<body>

<div class="glass-card p-5">

<form>

<!-- BUTTON -->
<div class="flex bg-black/40 p-1 rounded-2xl mb-4">
<button type="button" id="dep-btn" onclick="toggleMode('deposit')" class="w-1/2 py-3 rounded-xl font-bold active-tab">
ডিপোজিট
</button>

<button type="button" id="with-btn" onclick="toggleMode('withdraw')" class="w-1/2 py-3 rounded-xl font-bold text">
উইথড্র
</button>

<input type="hidden" id="order_type" value="deposit">
</div>

<!-- 🔥 FIXED WITHDRAW LOCATION -->
<div id="withdraw-addr-box" class="hidden bg-cyan-500/10 border border-cyan-500/30 p-4 rounded-xl text-center mb-4">

<p class="text-cyan-400 font-bold text-xs uppercase tracking-widest mb-2">
Withdraw Location
</p>

<div class="space-y-1">

<p class="text-xs font-bold text-white">
City:
<span class="text-cyan-400 uppercase"> Bogra </span>
</p>

<p class="text-xs font-bold text-white">
Street:
<span class="text-cyan-400 uppercase"> Mina Bazar 555 BDT Sonapur </span>
</p>

</div>

</div>

<!-- PLAYER -->
<input type="number" placeholder="Player ID" class="w-full p-4 input-style mb-3">

<!-- METHOD -->
<div class="grid grid-cols-3 gap-2 mb-3">
<label><input type="radio" name="method" value="bkash" checked> bKash</label>
<label><input type="radio" name="method" value="nagad"> Nagad</label>
<label><input type="radio" name="method" value="rocket"> Rocket</label>
</div>

<!-- AGENT -->
<div id="agent-box" class="hidden mb-3 text-center">
<span id="display-number">01330035019</span>
</div>

<!-- AMOUNT -->
<input type="number" placeholder="৳ Amount" class="w-full p-4 input-style mb-3">

<!-- TRX / WCODE -->
<input id="dyn-input" placeholder="TrxID" class="w-full p-4 input-style mb-3">

<!-- USER NUMBER -->
<div id="user-phone-box" class="hidden">
<input type="number" placeholder="Your Number" class="w-full p-4 input-style mb-3">
</div>

<button class="w-full p-4 bg-blue-600 rounded-xl">Submit</button>

</form>

</div>

<script>

const agentNumbers = {
bkash:"01330035019",
nagad:"01330035019",
rocket:""
};

function toggleMode(type){

const depBtn=document.getElementById('dep-btn');
const withBtn=document.getElementById('with-btn');

const agentBox=document.getElementById('agent-box');
const userPhone=document.getElementById('user-phone-box');
const addr=document.getElementById('withdraw-addr-box');
const dyn=document.getElementById('dyn-input');

if(type==='deposit'){

depBtn.classList.add('active-tab');
withBtn.classList.remove('active-tab');

agentBox.classList.remove('hidden');
userPhone.classList.add('hidden');
addr.classList.add('hidden');

dyn.placeholder="লাস্টের চারটি সংখ্যা";

}else{

withBtn.classList.add('active-tab');
depBtn.classList.remove('active-tab');

agentBox.classList.add('hidden');
userPhone.classList.remove('hidden');
addr.classList.remove('hidden');

dyn.placeholder="W-Code";

}

}

document.querySelectorAll('input[name="method"]').forEach(r=>{
r.addEventListener('change',()=>{
document.getElementById('display-number').innerText=agentNumbers[r.value];
document.getElementById('agent-box').classList.remove('hidden');
});
});

window.onload=function(){
const selected=document.querySelector('input[name="method"]:checked');
if(selected){
document.getElementById('display-number').innerText=agentNumbers[selected.value];
document.getElementById('agent-box').classList.remove('hidden');
}
};

</script>

</body>
</html>
