var selectPage = "Prender";
var reversePage = "Prender";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	functionPrender();

	window.addEventListener("message",function(event){
		switch (event["data"]["action"]){
			case "openSystem":
				$("#mainPage").css("display","block");
			break;

			case "closeSystem":
				$("#mainPage").css("display","none");
			break;

			case "reloadPrison":
				functionPrender();
			break;

			case "reloadFine":
				functionMultar();
			break;

			case "reloadSearch":
				functionSearch(event["data"]["data"]);
			break;
		};
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://police/closeSystem");
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

			if (selectPage == "penal"){
				$("#content").css("margin","30px");
				$("#content").css("height","460px");
			} else {
				$("#content").css("height","414px");
				$("#content").css("margin","76px 30px 30px 30px");
			}
		};
	};
});
/* ----------FUNCTIONSEARCH---------- */

function drawFicha(data) {
	return `
	<div class="recordBox">
		<div class="fineSeachTitle">
			<span style="width: 250px; float: left;"><b>Policial:</b> ${data["police"]}</span>
			<span style="width: 125px; float: left;"><b>Serviços:</b> ${data["services"]}</span>
			<span style="width: 110px; float: left;"><b>Multa:</b> $${data["fines"]}</span>
			<span style="width: 150px; float: right; text-align: right;">${data["date"]} ás ${data["date2"]}</span>
		</div>
		${data["text"]}
	</div>
	`
}
const functionSearch = (passaporte) => {
	if (passaporte != ""){
		$.post("http://police/searchUser",JSON.stringify({ passaporte: parseInt(passaporte) }),(data) => {
			// console.log(JSON.stringify(data))
		
			if (format(passaporte) >= 0){
				if (data[0]["name"] != undefined) {
					if (data[0]["police"] != undefined) {
						$('#content').html(`
								<div id="titleContent"></div>
									<div id="pageLeftSearch">
									<div class="searchBox">
										<b>Passaporte:</b> ${format(passaporte)}<br>
										<b>Telefone:</b> ${data[0]["phone"]}<br>
										<b>Nome:</b> ${data[0]["name"]}<br>
										<b>Multas:</b> $${data[0]["multa"]}<br>
									</div>
									
										${data.map((data) => (
										`
											<div class="recordBox">
												<div class="fineSeachTitle">
													<span style="width: 250px; float: left;"><b>Policial:</b> ${data["police"]}</span>
													<span style="width: 125px; float: left;"><b>Serviços:</b> ${format(data["services"])}</span>
													<span style="width: 110px; float: left;"><b>Multa:</b> $${format(data["fines"])}</span>
													<span style="width: 150px; float: right; text-align: right;">${data["date"]}</span>
												</div>
												${data["text"]}
											</div>
										`)).join('')}
									</div>

									<div id="pageRight">
										<h2>OBSERVAÇÕES:</h2>
										<b>1:</b> Todas as informações encontradas são de uso exclusivo policial, tudo que for encontrado na mesma são informações em tempo real.<br><br>
										<b>2:</b> Nunca forneça qualquer informação dessa página para outra pessoa, apenas se a mesma for o proprietário ou o advogado do mesmo.
									</div>
						`);
					} else {
						$('#content').html(`
								<div id="titleContent"></div>
									<div id="pageLeftSearch">
									<div class="searchBox">
										<b>Passaporte:</b> ${format(passaporte)}<br>
										<b>Telefone:</b> ${data[0]["phone"]}<br>
										<b>Nome:</b> ${data[0]["name"]}<br>
										<b>Multas:</b> $${data[0]["multa"]}<br>
									</div>
									</div>

									<div id="pageRight">
										<h2>OBSERVAÇÕES:</h2>
										<b>1:</b> Todas as informações encontradas são de uso exclusivo policial, tudo que for encontrado na mesma são informações em tempo real.<br><br>
										<b>2:</b> Nunca forneça qualquer informação dessa página para outra pessoa, apenas se a mesma for o proprietário ou o advogado do mesmo.
									</div>
						`);
					}
				} else {
					$('#content').html(`
						<div id="titleContent">RESULTADO</div>
						Não foi encontrado informações sobre o passaporte procurado.
					`);
				}

			}
		});
	};
};

/* ----------BUTTONSEARCH---------- */
$(document).on("click",".buttonSearch",function(e){
	const passaporte = $('#searchPassaporte').val();
	functionSearch(passaporte);
});
/* ----------CLICKBUY---------- */
$(document).on("click","#portSearch",function(e){
	$.post("http://police/updatePort",JSON.stringify({ passaporte: e["target"]["dataset"]["id"] }));
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionPrender = () => {
	selectPage = "Prender";

	$('#content').html(`
		<div id="titleContent">PRENDER</div>
		<div id="pageLeft">
			<input class="inputPrison" id="prenderPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputPrison" id="prenderServices" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Serviços."></input>
			<input class="inputPrison2" id="prenderMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaPrison" maxlength="500" id="prenderTexto" value="" placeholder="Todas as informações dos crimes."></textarea>
			<button class="buttonPrison">Prender</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
			<b>3:</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.
		</div>
	`);
};
/* ---------------------------------------------------------------------------------------------------------------- */
const functionLogs = () => {
	selectPage = "Logs";

	$.post("http://police/requestLogs",JSON.stringify({}),(data) => {
		$('#content').html(`
			<div id="titleContent">LOGS</div>
			<div id="pageLeft">
				${data["result"].map((data) => (`
					<div class="logsBox">${data["text"]}</div>
				`)).join('')}
			</div>

			<div id="pageRight">
				<h2>OBSERVAÇÕES:</h2>
				<b>1:</b> Todas as informações encontradas ficam salvas automaticamente do banco de dados após qualquer ação no tablet, assim evitando que os dados sejam perdidos com futuras atualizações no sistema.
			</div>
		`);
	});
};
/* ----------BUTTONPRISON---------- */
$(document).on("click",".buttonPrison",function(e){
	const passaporte = $('#prenderPassaporte').val()
	const servicos = $('#prenderServices').val()
	const multas = $('#prenderMultas').val()
	const texto = $('#prenderTexto').val()

	if (passaporte != "" && servicos != "" && multas != "" && texto != ""){
		$.post("http://police/initPrison",JSON.stringify({
			passaporte: parseInt(passaporte),
			servicos: parseInt(servicos),
			multas: parseInt(multas),
			texto: texto
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionMultar = () => {
	selectPage = "Multar";

	$('#content').html(`
		<div id="titleContent">MULTAR</div>
		<div id="pageLeft">
			<input class="inputFine" id="multarPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputFine2" id="multarMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaFine" id="multarTexto" maxlength="500" value="" placeholder="Todas as informações da multa."></textarea>
			<button class="buttonFine">Multar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com a multa, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
		</div>
	`);
};
/* ----------BUTTONFINE---------- */
$(document).on("click",".buttonFine",function(e){
	const passaporte = $('#multarPassaporte').val()
	const multas = $('#multarMultas').val()
	const texto = $('#multarTexto').val()

	if (passaporte != "" != "" && multas != "" && texto != ""){
		$.post("http://police/initFine",JSON.stringify({
			passaporte: parseInt(passaporte),
			multas: parseInt(multas),
			texto: texto
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionPenal = () => {
	selectPage = "penal";

	$("#content").html(`
		<div id="penalTitle01">CRIMES</div>
		<div id="penalTitle02">SERVIÇOS</div>
		<div id="penalTitle03">MULTAS</div>
		<div id="penalTitle04">OBSERVAÇÕES</div>

		<div class="lineColor">
			<div id="penalContent01">Ameaça</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Ameaçar alguém por palavra, escrito ou gesto.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Associação criminosa</div>
			<div id="penalContent02">20</div>
			<div id="penalContent03">$500</div>
			<div id="penalContent04">Associarem-se 3 ou mais pessoas, para fim específico de cometer crimes.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Corridas ilegais</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$275</div>
			<div id="penalContent04">Participar de corridas clandestinas.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Conspiração</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$500</div>
			<div id="penalContent04">Planejar atividade ilegal.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Corrupção</div>
			<div id="penalContent02">250</div>
			<div id="penalContent03">$100.000</div>
			<div id="penalContent04">Solicitar, receber, obter ou utilizar para si ou para outrem, diretamente ou indiretamente.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Comportamento Indisciplinar</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$10.000</div>
			<div id="penalContent04">Se comportar indevidamente com base no seu emprego.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Dano ao Patrimônio Pessoal</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$2.750</div>
			<div id="penalContent04">Danificar o bem de outra pessoa.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Dano ao Patrimônio Estadual</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$5.250</div>
			<div id="penalContent04">Danificar o bem do estado.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Denuncia caluniosa</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$500</div>
			<div id="penalContent04">Dar causa à instauração de investigação policial de processo judicial.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Desacato</div>
			<div id="penalContent02">30</div>
			<div id="penalContent03">$3.750</div>
			<div id="penalContent04">Desacatar funcionário público no exercício de sua função ou em razão dela.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Desobediência</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$500</div>
			<div id="penalContent04">Desobedecer ordem de funcionário público.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Dólares Ilícitos</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">0</div>
			<div id="penalContent04">Em roubos de grande porte a pena é dobrada.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Estelionato</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Obter para si ou para outrem vantagem ilícita em prejuízo alheio.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Extorsão</div>
			<div id="penalContent02">30</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Obrigar a tomar um determinado comportamento por meio de ameaça ou violência.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Falsidade ideologica / Falsa identidade</div>
			<div id="penalContent02">20</div>
			<div id="penalContent03">$1.500</div>
			<div id="penalContent04">Atribuir à si ou a terceiros falsa identidade para obter vantagem em proveito alheio.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Falso testemunho</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$500</div>
			<div id="penalContent04">Fazer afirmação falsa, negar ou calar a verdade.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Fraude</div>
			<div id="penalContent02">20</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Mentorar ou participar de esquema ilícito ou de má-fé visando obter vantagens.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Fuga</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$525</div>
			<div id="penalContent04">Evadir-se da polícia.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Furto</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$375</div>
			<div id="penalContent04">Subtrair, para si ou para outrem coisa móvel alheia.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Injúria</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Injuriar alguém, ofendendo-lhe a dignidade ou o decoro.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Invasão</div>
			<div id="penalContent02">20</div>
			<div id="penalContent03">$375</div>
			<div id="penalContent04">Invadir áreas privadas, ou públicas de acesso restrito.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Latrocínio</div>
			<div id="penalContent02">35</div>
			<div id="penalContent03">$1.750</div>
			<div id="penalContent04">Roubo seguido de morte.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Lesão corporal</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Ofender a integridade corporal ou a saúde de outrem.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Multas não pagas</div>
			<div id="penalContent02">5 / $500</div>
			<div id="penalContent03">0</div>
			<div id="penalContent04">Multas com atrasao de 24 horas no pagamento.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Objetos roubados</div>
			<div id="penalContent02">2 / 1</div>
			<div id="penalContent03">$25 / 1</div>
			<div id="penalContent04">Objetos subtraidos através de roubos.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Obstrução da justiça</div>
			<div id="penalContent02">50</div>
			<div id="penalContent03">$2.750</div>
			<div id="penalContent04">Cometer o impedimento ou qualquer forma que atrapalhe a investigação.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Ocultação Facial</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$15.750</div>
			<div id="penalContent04">Utilização de adornos ou acessórios que ocultem totalmente ou parcialmente a face.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Omissão de socorro</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$1.500</div>
			<div id="penalContent04">Deixar de prestar assistência, quando possível fazê-lo sem risco pessoal ou ferida.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Perseguição</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$1.250</div>
			<div id="penalContent04">Seguir alguém, perseguir ou qualquer coisa do genero.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Porte/Posse ilegal de armas classe 1</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Porte / Posse ilegal de armas semi-automáticas.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Porte/Posse ilegal de armas classe 2</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$1.250</div>
			<div id="penalContent04">Porte / Posse ilegal de armas automáticas.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Produtos Ilícitos</div>
			<div id="penalContent02">15</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Produto adquirido por roubos ou utilizado para crimes.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Receptação</div>
			<div id="penalContent02">30</div>
			<div id="penalContent03">0</div>
			<div id="penalContent04">Receptar, em proveito próprio ou alheio, coisa que se saiba ser produto de crime.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Resistência</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Opor-se à execução de ato legal, mediante violência ou ameaça ao funcionário.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Roubo</div>
			<div id="penalContent02">20</div>
			<div id="penalContent03">$1.250</div>
			<div id="penalContent04">Subtrair posses alheias, para si ou para outrem, mediante grave ameaça ou violência.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Roupas policiais</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$2.750</div>
			<div id="penalContent04">Utilizar qualquer utilitário exclusivo policial.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Sequestro</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$1.500</div>
			<div id="penalContent04">Privar alguém de sua liberdade mediante sequestro ou cárcere privado.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Suborno</div>
			<div id="penalContent02">25</div>
			<div id="penalContent03">$2.500</div>
			<div id="penalContent04">Oferecer ou prometer vantagem indevida a funcionário público.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Tentativa / Homicídio</div>
			<div id="penalContent02">30</div>
			<div id="penalContent03">$1.250</div>
			<div id="penalContent04">Quando o suspeito quis o resultado e assumiu o risco de produzí-lo.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Tentativa / Homicídio Oficial</div>
			<div id="penalContent02">35</div>
			<div id="penalContent03">$2.250</div>
			<div id="penalContent04">Quando o suspeito quis o resultado e assumiu o risco de produzí-lo em um oficial do governo.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Terrorismo</div>
			<div id="penalContent02">50</div>
			<div id="penalContent03">$5.250</div>
			<div id="penalContent04">Cuja violência ilegítima passa a denominar-se terror.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Tráfico classe 1</div>
			<div id="penalContent02">1</div>
			<div id="penalContent03">0</div>
			<div id="penalContent04">Para cada 2 drogas possuídas.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Tráfico classe 2</div>
			<div id="penalContent02">2</div>
			<div id="penalContent03">0</div>
			<div id="penalContent04">Para cada 25 <s>Munições</s> possuídas.</div>
		</div>

		<div id="penalDivision"></div>

		<div id="penalTitle01">INFRAÇÕES</div>
		<div id="penalTitle02">SERVIÇOS</div>
		<div id="penalTitle03">MULTAS</div>
		<div id="penalTitle04">OBSERVAÇÕES</div>

		<div class="lineColor">
			<div id="penalContent01">Alta velocidade</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$550</div>
			<div id="penalContent04">Aumenta $50 dólares a cada 10mph.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Direção imprudente</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Conduta imprudente no transito utilizando um caminhão ou ônibus.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Direção perigosa</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Uso negligente ou imprudente de um veículo.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Estacionar em local proibido</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$750</div>
			<div id="penalContent04">Deixar o veículo em local indevido.</div>
		</div>

		<div class="lineColor">
			<div id="penalContent01">Pousar em local proibido ou sem designação</div>
			<div id="penalContent02">0</div>
			<div id="penalContent03">$17.500</div>
			<div id="penalContent04">Pousar veículos aéreos fora de locais adequados e seguros.</div>
		</div>

		<div id="penalDivision"></div>

		<div id="titlePenal">OBSERVAÇÕES GERAIS</div>
		<div id="pagePenal">
			<b>1:</b> Posse legal de joint é até <s>5 unidades</s>, passando da quantidade legal o mesmo é indiciado pelo crime de Tráfico.<br>
			<b>2:</b> Veículos são apreendidos quando o condutor/passageiro atenta contra a vida utilizando uma arma de fogo ou quando o veículo é jogado no mar propositalmente.<br>
			<b>3:</b> Cada serviço pode ser convertido em <s>$500</s> dólares, crimes que atentam contra a vida de outro cidadão não estão sujeitas a fiança.<br>
			<b>4:</b> Não há crime de cumplicidade, as pessoas que colaboram diretamente ou indiretamente para o crime recebem a mesma pena.<br>
			<b>5:</b> Limite de velocidade dentro da cidade é de <s>75 Mph</s>, veículos de grande porte o limite de velocidade é de <s>40 Mph</s>.
		</div>
	`);
};
/* ----------format---------- */
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