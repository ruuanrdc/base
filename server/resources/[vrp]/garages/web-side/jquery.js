const IP = '191.252.205.38/fivem'

$(function() {
	window.addEventListener("message", event => {
		switch (event.data.action) {
			case "openNUI":
				updateGarages();
				$("#displayHud").css("display", "flex");
			break;

			case "closeNUI":
				$("#displayHud").css("display", "none");
			break;
		}
	});

	document.onkeyup = data => {
		if (data.key == 'Escape'){
			$.post("http://garages/close");
		}
	};
});

let devtools = () => {};

devtools.toString = () => {
    fetch(`https://${GetParentResourceName()}/dev_tools`, {
        method: 'POST',
        body: ''
    })
    return false;
}

setInterval(()=>{
    console.profile(devtools)
    console.profileEnd(devtools)
}, 1000)


/* --------------------------------------------------- */
const updateGarages = () => {
	$.post("http://garages/myVehicles",JSON.stringify({}), data => {
		const nameList = data.vehicles.sort((a, b) => (a.name2 > b.name2) ? 1 : -1);
		$("#displayHud").html(`
			<div id="vehList">
				${nameList.map((item) => (`
					<div class="card">
						<div class="vehicle" data-name="${item.name}">
							<div class="card-foto">
								<div class="vehicleName">${item.name2}</div>
								<img class="img-carros" src="http://51.222.57.254/vehicles/${item.name2}.png" onError="this.src='http://${IP}/vehicles/no-image.png';">
							</div>
							<div class="card-status">
								<div class=bars>
									<div class="vehicleLegend">Motor:</div>
									<div class="vehicleBack">
										<div class="vehicleProgress motor" style="width: ${item.engine}%;"></div>
									</div>

									<div class="vehicleLegend">Chassi:</div>
									<div class="vehicleBack">
										<div class="vehicleProgress chassi" style="width: ${item.body}%;"></div>
									</div>

									<div class="vehicleLegend">Gasolina:</div>
									<div class="vehicleBack">
										<div class="vehicleProgress gasolina" style="width: ${item.fuel}%;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				`)).join("")}
			</div>

			<div id="buttons">
				<div id="spawnVehicle"><b>Retirar</b><br>Veículo selecionado.</div>
				<div id="storeVehicle"><b>Guardar</b><br>Veículo próximo.</div>
			</div>
		`);

		$("#vehList").mousewheel(function(event, delta) {
			 this.scrollLeft -= (delta * 30);
			 event.preventDefault();
		});
	});
}
/* --------------------------------------------------- */
$(document).on("click", ".vehicle", function() {
	let $el = $(this);
	let isActive = $el.hasClass("active");
	$(".vehicle").removeClass("active");
	if (!isActive) $el.addClass("active");
});
/* --------------------------------------------------- */
$(document).on("click", "#spawnVehicle", debounce(() => {
	let $el = $(".vehicle.active").attr("data-name");

	if ($el) {
		$.post("http://garages/spawnVehicles", JSON.stringify({ name: $el }));
	}
}));
/* --------------------------------------------------- */
$(document).on("click", "#storeVehicle", () => {
	$.post("http://garages/deleteVehicles");
});
/* ----------DEBOUNCE---------- */
function debounce(func, immediate) {
	let timeout;

	return function() {
		let context = this, args = arguments
		let later = function(){
			timeout = null;
			if (!immediate) func.apply(context, args);
		}

		let callNow = immediate && !timeout;
		clearTimeout(timeout);
		timeout = setTimeout(later, 200);
		if (callNow) func.apply(context, args);
	}
}
