var reversePage = "about";
var selectPage = "about";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){

	aboutPage();

	window.addEventListener("message",function(event){
		switch (event.data.action) {
			case "openSystem":
				$("#mainPage").fadeIn(100);
			break;

			case "closeSystem":
				$("#mainPage").fadeOut(100);
			break;

			case "messageMedia":
				updateMedia(event.data.media,event.data.data,event.data.back)
			break;
		};
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://tablet/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click","#mainMenu li",function(){
	if (selectPage != reversePage){
		let isActive = $(this).hasClass('active');
		$('#mainMenu li').removeClass('active');
		if (!isActive){
			$(this).addClass('active');
			reversePage = selectPage;
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const bichoPage = () => {
	selectPage = "bicho";

	$('#content').html(`
	<div id='titleContent'>PRINCIPAIS</div>
		<div id='pageDiv'>
		<b>1</b> - Avestruz<br>
		<b>2</b> - Águia<br>
		<b>3</b> - Burro<br>
		<b>4</b> - Borboleta<br>
		<b>5</b> - Cachorro<br>
		<b>6</b> - Cabra<br>
		<b>7</b> - Carneiro<br>
		<b>8</b> - Camelo<br>
		<b>9</b> - Cobra<br>
		<b>10</b> - Coelho<br>
		<b>11</b> - Cavalo<br>
		<b>12</b> - Elefante<br>
		<b>13</b> - Galo<br>
		</div>
		<div id='pageDiv'>
		<b>14</b> - Gato<br>
		<b>15</b> - Jacaré<br>
		<b>16</b> - Leão<br>
		<b>17</b> - Macaco<br>
		<b>18</b> - Porco<br>
		<b>19</b> - Pavão<br>
		<b>20</b> - Peru<br>
		<b>21</b> - Touro<br>
		<b>22</b> - Tigre<br>
		<b>23</b> - Urso<br>
		<b>24</b> - Veado<br>
		<b>25</b> - Vaca<br>
		</div>
	`);
};
/* ----------ABOUT---------- */
const aboutPage = () => {
	selectPage = "about";

	$.post("http://tablet/requestAbout",JSON.stringify({}),(data) => {

		$("#content").html(`
			<div id="titleContent">SOBRE</div>
			<div id="aboutInfos">
				<b>Nome:</b> <span id="aboutResult">${data.infos[0]}</span><br>
				<b>Passaporte:</b> <span id="aboutResult">${data.infos[1]}</span><br>
				<b>Telefone:</b> <span id="aboutResult">${data.infos[4]}</span><br>
				<b>Identidade:</b> <span id="aboutResult">${data.infos[5]}</span><br>
				<b>Saldo Bancário:</b> <span id="aboutResult">$${format(data.infos[2])}</span><br>
				<b>Gemas:</b> <span id="aboutResult">${format(data.infos[3])}</span><br>
			</div>

			<div id="animalGame">
			<b>JOGO DO BICHO</b><br>
			Você pode apostar uma vez em cada bicho disponível.<br>
			<input id="gameValue" class="gameValue" type="number" spellcheck="false" onKeyPress="if(this.value.length==9) return false;" value="" placeholder="VALOR..">
			<input id="gameAnimal" class="gameValue" type="number" spellcheck="false" onKeyPress="if(this.value.length==1) return false;" value="" placeholder="BICHO..">
			<div id="gameSubmit"><i class="material-icons done">VAI</i></div>

			<div id="gameLegends">
				<div id="gameCollum">
					<b>1:</b> Camelo<br>
					<b>2:</b> Pavão<br>
					<b>3:</b> Elefante
				</div>
				<div id="gameCollum">
					<b>4:</b> Coelho<br>
					<b>5:</b> Burro<br>
					<b>6:</b> Gato
				</div>
				<div id="gameCollum">
					<b>7:</b> Galo<br>
					<b>8:</b> Tigre<br>
					<b>9:</b> Rato
				</div>
			</div>
		</div>
	`);
});
};
/* ----------GAMESUBMIT---------- */
$(document).on("click","#gameSubmit",function(e){
	let value = parseInt($("#gameValue").val());
	let animal = parseInt($("#gameAnimal").val());

	if (value > 0 && animal > 0){
		$.post("http://tablet/inputGame",JSON.stringify({ value: value, animal: animal }));
	}
	$("#gameValue").val('')
	$("#gameAnimal").val('')
});
/* ---------------------------------------------------------------------------------------------------------------- */
const racesPage = (raceId) => {
    selectPage = "races";

    if (raceId == undefined){
        raceId = 1;
    }

    $("#content").html(`
        <div id="raceBar">
            <li id="circuits" data-id="1" ${raceId == 1 ? "class=active":""}>01</li>
            <li id="circuits" data-id="2" ${raceId == 2 ? "class=active":""}>02</li>
            <li id="circuits" data-id="3" ${raceId == 3 ? "class=active":""}>03</li>
            <li id="circuits" data-id="4" ${raceId == 4 ? "class=active":""}>04</li>
            <li id="circuits" data-id="5" ${raceId == 5 ? "class=active":""}>05</li>
            <li id="circuits" data-id="6" ${raceId == 6 ? "class=active":""}>06</li>
            <li id="circuits" data-id="7" ${raceId == 7 ? "class=active":""}>07</li>
            <li id="circuits" data-id="8" ${raceId == 8 ? "class=active":""}>08</li>
            <li id="circuits" data-id="9" ${raceId == 9 ? "class=active":""}>09</li>
            <li id="circuits" data-id="10" ${raceId == 10 ? "class=active":""}>10</li>
            <li id="circuits" data-id="11" ${raceId == 11 ? "class=active":""}>11</li>
            <li id="circuits" data-id="12" ${raceId == 12 ? "class=active":""}>12</li>
            <li id="circuits" data-id="13" ${raceId == 13 ? "class=active":""}>13</li>
            <li id="circuits" data-id="14" ${raceId == 14 ? "class=active":""}>14</li>
            <li id="circuits" data-id="15" ${raceId == 15 ? "class=active":""}>15</li>
            <li id="circuits" data-id="16" ${raceId == 16 ? "class=active":""}>16</li>
        </div>

        <div id="raceContent"></div>
    `);

    $.post("http://tablet/requestRanking",JSON.stringify({ id: raceId }),(data) => {
        let position = 0;

        $.each(data,(k,v) => {
            $('#raceContent').append(`
                <div id="raceLine">
                    <div class="racePosition">${position = position + 1}</div>
                    <div class="raceName">${v["lastname"]} ${(position == 1 || position == 2 || position == 3) ? "<img src=\"images/"+position+".png\">":""}</div>
                    <div class="raceVehicle">${v["vehicle"]}</div>
					<div class="racePoints">${format(v["points"])} Pontos</div>
                    <div class="raceDate">${v["date"]}</div>
                </div>
            `);
        });
    });
};
/* ----------CLICKRACES---------- */
$(document).on("click","#circuits",function(e){
    racesPage(e["target"]["dataset"]["id"]);
});
/* ---------------------------------------------------------------------------------------------------------------- */
var benMode = "Carros"
var benSearch = "alphabetic"

const searchTypePage = (mode) => {
	benSearch = mode;
	benefactor(benMode);
}
/* ---------------------------------------------------------------------------------------------------------------- */
const benefactor = (mode) => {
	benMode = mode;
	selectPage = "benefactor";
	$("#content").html(`
		<div id="raceBar">
		<li id="benefactor" data-id="Carros" ${mode == "Carros" ? "class=active":""}>CARROS</li>
		<li id="benefactor" data-id="Motos" ${mode == "Motos" ? "class=active":""}>MOTOS</li>
		<li id="benefactor" data-id="Aluguel" ${mode == "Aluguel" ? "class=active":""}>ALUGUEL</li>
		<li id="benefactor" data-id="Servicos" ${mode == "Servicos" ? "class=active":""}>SERVIÇOS</li>
		<li id="benefactor" data-id="Possuidos" ${mode == "Possuidos" ? "class=active":""}>POSSUÍDOS</li>
		</div>

		<div id="contentVehicles">
			<div id="titleVehicles">${mode}</div>
			<div id="typeSearch"><span onclick="searchTypePage('alphabetic');">Ordem Alfabética</span> / <span onclick="searchTypePage('crescent');">Valor Crescente</span></div>
			<div id="pageVehicles"></div>
		</div>
	`);

	$.post(`http://tablet/request`+ mode,JSON.stringify({}),(data) => {
		let i = 0;
		if (benSearch == "alphabetic"){
			var nameList = data.veiculos.sort((a,b) => (a["name"] > b["name"]) ? 1: -1);
		} else {
			var nameList = data.veiculos.sort((a,b) => (a["price"] > b["price"]) ? 1: -1);
		}

		if (mode !== "Possuidos"){
			$("#pageVehicles").html(`
				${nameList.map((item) => (`<span>
				<img src="http://51.222.57.254/vehicles/${item.name}.png" style="margin-left: 3.5vw; margin-top: 1vw; width: 7vw; height: 4vw;">
					<left>
						${item["name"]}<br>
						<b>Valor:</b> ${mode == "Aluguel" ? format(item["price"])+" Gemas":"$"+format(item["price"])}<br>
						<b>Taxa:</b> $${format(item["tax"])}<br>
						<b>Porta-Malas:</b> ${format(item["chest"])}Kg
					</left>
					<right>
						${mode == "Aluguel"?"<div id=\"benefactorRental\"data-name="+item["k"]+">ALUGAR</div>":"<div id=\"benefactorBuy\" data-name="+item["k"]+">COMPRAR</div>"}
						<div id="benefactorDrive" data-name="${item["k"]}">TESTAR</div>
					</right>
				</span>`)).join('')}
			`);
		} else {
			$("#pageVehicles").html(`
				${nameList.map((item) => (`<span>
				<img src="http://51.222.57.254/vehicles/${item.name}.png" style="margin-left: 3.5vw; margin-top: 1vw; width: 7vw; height: 4vw;">
					<left>
						${item["name"]}<br>
						<b>Valor:</b> ${mode == "Aluguel" ? format(item["price"])+" Gemas":"$"+format(item["price"])}<br>
						<b>Porta-Malas:</b> ${format(item["chest"])}Kg
					</left>
					<right>
						<div id="benefactorSell" data-name="${item["k"]}">VENDER</div>
						<div id="benefactorTax" data-name="${item["k"]}">PAGAR</div>
					</right>
				</span>`)).join('')}
			`);
		}
	});
};
/* ----------BENEFACTOR---------- */
$(document).on("click","#benefactor",function(e){ benefactor(e["target"]["dataset"]["id"]);
});
/* ----------BENEFACTORBUY---------- */
$(document).on("click","#benefactorBuy",function(e){
	$.post("http://tablet/buyDealer",JSON.stringify({name: e["target"]["dataset"]["name"]}));
	benefactor("Carros");
});
/* ----------BENEFACTORRENTAL---------- */
$(document).on("click","#benefactorRental",function(e){
	$.post("http://tablet/buyDealer",JSON.stringify({name: e["target"]["dataset"]["name"]}));
	benefactor('Carros');
});
/* ----------BENEFACTORSELL---------- */
$(document).on("click","#benefactorSell",function(e){
	$.post("http://tablet/sellDealer",JSON.stringify({name: e["target"]["dataset"]["name"]}));
	$.post("http://tablet/closeSystem");
	benefactor('Carros');
});
/* ----------BENEFACTORTAX---------- */
$(document).on("click","#benefactorTax",function(e){
	$.post("http://tablet/requestTax",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
	benefactor('Carros');
});
/* ----------BENEFACTORDRIVE---------- */
$(document).on("click","#benefactorDrive",function(e){
	$.post("http://tablet/requestDrive",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
	benefactor('Carros');
	$.post("http://tablet/closeSystem");
});
/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}