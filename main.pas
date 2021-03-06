unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, jpeg, Math;

type
  TfGame = class(TForm)
    imgNave: TImage;
    imgNaveLeft: TImage;
    imgNaveRight: TImage;
    imgExplosion: TImage;
    imgNaveFull: TImage;
    Timer3: TTimer;
    imgEx8: TImage;
    imgEx4: TImage;
    imgEx3: TImage;
    imgEx2: TImage;
    imgEx1: TImage;
    imgEx5: TImage;
    imgEx6: TImage;
    ImgAlien: TImage;
    imgti1_13: TImage;
    ImgViper: TImage;
    imgt2: TImage;
    imgT5: TImage;
    imgT4: TImage;
    imgEx7: TImage;
    c5: TImage;
    c1: TImage;
    c2: TImage;
    c3: TImage;
    c4: TImage;
    c8: TImage;
    c7: TImage;
    c6: TImage;
    imgBoss1: TImage;
    e8: TImage;
    e4: TImage;
    e3: TImage;
    e2: TImage;
    e1: TImage;
    e5: TImage;
    e6: TImage;
    e7: TImage;
    e16: TImage;
    e12: TImage;
    e11: TImage;
    e10: TImage;
    e9: TImage;
    e13: TImage;
    e14: TImage;
    e15: TImage;
    imgtn2: TImage;
    f8: TImage;
    f4: TImage;
    f3: TImage;
    f2: TImage;
    f1: TImage;
    f5: TImage;
    f6: TImage;
    f7: TImage;
    imgSelfDestruct: TImage;
    imgSelfDestruct2: TImage;
    imgItemPowerup: TImage;
    imgCrystal: TImage;
    imgShield: TImage;
    imgBoss13: TImage;
    imgSelfDestruct1: TImage;
    imgt7_1: TImage;
    imgt7_2: TImage;
    imgCrystal2: TImage;
    imgSpecial1: TImage;
    imgSpecial2: TImage;
    imgSpecial3: TImage;
    imgSpecial4: TImage;
    imgSpecial5: TImage;
    imgSpecial6: TImage;
    imgSpecial7: TImage;
    imgSpecial8: TImage;
    imgSpecial9: TImage;
    imgSpecial10: TImage;
    imgSpecial11: TImage;
    imgSpecial12: TImage;
    imgSpecial13: TImage;
    imgSpecial14: TImage;
    imgSpecial15: TImage;
    imgSpecial16: TImage;
    imgEspecial1: TImage;
    imgtn12: TImage;
    imgtn13: TImage;
    imgRocket6_3: TImage;
    imgtn1_1: TImage;
    imgRocket6_1: TImage;
    imgRocket6_2: TImage;
    imgRocket7to8: TImage;
    imgRocket9: TImage;
    imgRocket10to11: TImage;
    imgRocket12: TImage;
    imgRocket1to2: TImage;
    imgRocket3: TImage;
    imgRocket4to5: TImage;
    imgNaveRightFull: TImage;
    imgNaveLeftFull: TImage;
    imgtn1_2: TImage;
    imgti1_23: TImage;
    imgti1_1: TImage;
    imgti1_2: TImage;
    imgTarget1: TImage;
    imgTarget2: TImage;
    imgTarget3: TImage;
    imgEspecial2: TImage;
    imgEspecial3: TImage;
    imgEspecial4: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  type ttipoitem = (crystal, powerUp, autoTargetWeapon);
	type tdirx = (dirxleft, dirxright, dirxnil);
  type tdiry = (diryup, dirydown, dirynil);
	type TTipoInimigo = (Alien, Viper, Boss1, selfDestructor);
  type ttipoanimacao = (explosao1, explosao2, explosao3, newItem, target, lightning);
  type ttipoarmaNave = (t1, t2, t3, t4, t5);


	type tArmaNave = record
   	tipo: ttipoarmaNave;
		damage: integer;
      nivel, frames: byte;
      altura, largura : byte;
      tempoCarregamento, municao: cardinal;
  	end;
  
  type tjogo = record
  	fase, crystals: cardinal;
   armas : array[1..10] of tarmanave;
  end;

	type tanimacao = record
   	frame, frames: byte;
    	tipo : ttipoanimacao;
		ativo: boolean;
		x, y, sx, sy: integer;
  	end;

  type tmensagem = record
  	x, y, sy, sx : integer;
    mensagem : string;
    ativo : boolean;
    tempo : cardinal;
    cor: tcolor;
  end;

  type tplaneta = record
  	x, y, speed : real;
    tipo :  byte;
  end;

	type tnave = record
   	x, y, sx, sy: real;
  		dirx: tdirx;
      diry : tdiry;
      energia: integer; // tem que ser inteiro, para permitir numeros negativos, porque pode acontecer que a forca do tiro inimigo seja maior do que a energia restante na nave, neste caso a energia fica negativa, e se a variavel forsse cardinal (nao permite negativos), a energia iria para o limite maximo da variavel e a verificacao que a energia da nave e menor que zero seria invalida e geraria um bug.
      shield: boolean;
      frame: byte;
      weaponIndex: byte;
      armas : array[1..5] of tarmanave;
      crystals, tempoCarregamentoEspecial: cardinal;
	end;

	type ttironave = record
  		x, y, sx, sy, accel, speed: real;
		ativo: boolean;
      lockonID: cardinal;
      frame : byte;
      arma: tarmanave;
	end;

  type ttiroinimigo = record
		x, y, sx, sy: real;
    largura, altura: cardinal;
    frames, frame: byte;
  	tipo, poder: byte;
		ativo: boolean;
	end;

  type TInimigo = record
  		ativo, boss: boolean;
  		tipo: TTipoInimigo;
		energia: integer;
    	x, y, sx, sy: real;
    	largura, altura: cardinal;
  end;

  type tEstrela = record
		x, y, speed: integer;
  end;

  type tItem = record
  	x, y: real;
    ativo : boolean;
    tipo : ttipoitem;
    altura, largura : byte;
  end;

const
	LARGURA_TELA = 800;
	ALTURA_TELA = 600;
	OFFSCREEN = 100;
   MAX_TIROS_NAVE = 50;
   MAX_INIMIGOS = 10;
   MAX_TIROS_INIMIGO = 50;
   LARGURA_NAVE = 40;
   ALTURA_NAVE = 40;
   MAX_ESTRELAS = 200;
   MAX_PLANETAS = 8;
   MAX_ITEMS = 50;
   MAX_MSG = 50;
   MAX_ENERGIA_NAVE = 150;

   MAX_ANIMACOES = 100;

   LARGURA_TIROS_INIMIGO : array[1..8] of Byte = (16, 12, 12, 16, 32, 0, 8, 0);
	ALTURA_TIROS_INIMIGO : array[1..8] of Byte = (16, 12, 15, 48, 32, 0, 6, 0);

   ARMA_T1 : tarmanave = (	tipo: t1;
   								damage: 1;
                           nivel: 1;
                           frames: 2;
                           altura: 23;
                           largura: 5;
                           tempoCarregamento: 10;
                           municao: 99999
   							);

	ARMA_T2 : tarmanave = (	tipo: t2;
   								damage: 3;
                           nivel: 1;
                           frames: 3;
                           altura: 28;
                           largura: 7;
                           tempoCarregamento: 15;
                           municao: 9999
   							);

	ARMA_T3 : tarmanave = (	tipo: t3;
   								damage: 1;
                           nivel: 1;
                           frames: 1;
                           altura: 23;
                           largura: 5;
                           tempoCarregamento: 10;
                           municao: 100
   							);

	ARMA_T4 : tarmanave = (	tipo: t4;
   								damage: 1;
                           nivel: 1;
                           frames: 1;
                           altura: 23;
                           largura: 5;
                           tempoCarregamento: 10;
                           municao: 100
   							);

   ARMA_T5 : tarmanave = (	tipo: t5;
   								damage: 1;
                           nivel: 1;
                           frames: 1;
                           altura: 23;
                           largura: 5;
                           tempoCarregamento: 10;
                           municao: 100
   							);
                        
var
  fGame: TfGame;

  Nave: TNave;
  BackBuffer: TBitmap;
  TirosNave: array[0..MAX_TIROS_NAVE] of TTironave;
  Inimigos: array[0..MAX_INIMIGOS] of TInimigo;
  tiros_inimigo: array[0..MAX_TIROS_INIMIGO] of TTiroInimigo;
  stars: array[0..MAX_ESTRELAS] of testrela;
  planetas : array[0..MAX_PLANETAS] of tplaneta;
  items : array[1..MAX_ITEMS] of tItem;
  mensagens : array[1..MAX_MSG] of tmensagem;
  animacoes : array[1..MAX_ANIMACOES] of tanimacao;
  gamecounter : int64;
  PodeAdicionarInimigo : integer;
  fase, subfase: cardinal;
  drawcounter : cardinal;
  PosicaoSubFase : cardinal;
  bossTime : boolean;
  FPS: cardinal;

  score : cardinal;

  oldHeight, oldWidth : cardinal;

  Jogo : tjogo;

  tempoAcessoMenu : cardinal; // regula as teclas dos menus
  
implementation

{$R *.dfm}

procedure SetScreenResolution(const width, height, colorDepth : integer); overload;
var
	mode:TDevMode;
begin
	zeroMemory(@mode, sizeof(TDevMode));
	mode.dmSize := sizeof(TDevMode);
  	mode.dmPelsWidth := width;
  	mode.dmPelsHeight := height;
  	mode.dmBitsPerPel := colorDepth;
  	mode.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL;
  	ChangeDisplaySettings(mode, 0);
end;

procedure enviarmsg(msg: string; cor: tcolor; x, y, sx, sy : cardinal; time: cardinal);
var
	i : cardinal;
begin
	for i := 1 to MAX_MSG do
  	if not mensagens[i].ativo then
    begin
  		mensagens[i].ativo := true;
      mensagens[i].x := x;
      mensagens[i].y := y;
			mensagens[i].sx := sx;
      mensagens[i].sy := sy;
			mensagens[i].tempo := time;
      mensagens[i].mensagem := msg;
      mensagens[i].cor := cor;
      break;
    end;
end;

procedure moverMensagens();
var
	i: integer;
begin
	for i := 1 to MAX_MSG do
		if mensagens[i].ativo then
    begin
    	mensagens[i].y := mensagens[i].y - mensagens[i].sy;
      mensagens[i].x := mensagens[i].x - mensagens[i].sx;
    end;
end;

procedure SalvarDadosJogo(); // dados do jogo no inicio de cada fase
var
	i : cardinal;
begin
	jogo.fase := fase;
   jogo.crystals := nave.crystals;
   for i := 1 to 10 do
   	jogo.armas[i] := nave.armas[i];
end;

procedure limparCenario();
var
	i: cardinal;
begin
	for i := 1 to MAX_INIMIGOS do
   	inimigos[i].ativo := false;
   for i := 1 to MAX_TIROS_INIMIGO do
   	tiros_inimigo[i].ativo := false;
   for i := 1 to MAX_ITEMS do
   	items[i].ativo := false;
   for i := 1 to MAX_ANIMACOES do
   	animacoes[i].ativo := false;
   for i := 1 to MAX_INIMIGOS do
   	inimigos[i].ativo := false;
   for i := 1 to MAX_MSG do
   	mensagens[i].ativo := false;
   for i := 1 to MAX_TIROS_NAVE do
   	tirosnave[i].ativo := false;
end;

procedure iniciarNave();
begin
	nave.frame := 1;
	Nave.x := LARGURA_TELA div 2 - 30;
	Nave.y := ALTURA_TELA - ALTURA_NAVE - 30;
   nave.sx := 5;
   nave.sy := 5;

   nave.energia := MAX_ENERGIA_NAVE;
   nave.weaponIndex := 1;
   nave.crystals:= 10000;

   nave.armas[1] := ARMA_T1;
   nave.armas[2] := ARMA_T2;
   nave.armas[3] := ARMA_T3;
   nave.armas[4] := ARMA_T4;
   nave.armas[5] := ARMA_T5;
end;

procedure novoJogo();
begin
   fase := 1;
   subfase := 1;
   PosicaoSubFase := 1;
   gamecounter := 0;

   iniciarNave();

	limparCenario();
end;

procedure salvar();
var
	arquivo : file of tjogo;
begin
	assignfile(arquivo, 'save.sav');
   rewrite(arquivo);

   write(arquivo, jogo);
   closefile(arquivo);

   enviarmsg('Stage saved successfully', clAqua, LARGURA_TELA div 2 - 100, ALTURA_TELA div 2 - 50, 0, 0, 100);
end;

procedure carregar();
var
	arquivo : file of tjogo;
   carregJogo : tjogo;
   i : cardinal;
begin
   assignfile(arquivo, 'save.sav');
	filemode := fmopenread;
   reset(arquivo);

   read(arquivo, carregJogo);

	fase := carregJogo.fase;
   subfase := 1;
   posicaosubFase := 1;
   gameCounter:= 0;

   nave.crystals := carregJogo.crystals;

   for i := 1 to 10 do
   	nave.armas[i] := carregJogo.armas[i];

   nave.energia := MAX_ENERGIA_NAVE;

   closefile(arquivo);

   limparCenario();

  	Nave.x := LARGURA_TELA div 2 - 30;
	Nave.y := ALTURA_TELA - ALTURA_NAVE - 30;
end;

procedure MenuUpgrade();
var
	menubmp : tbitmap;
   option: byte;
   msg: string;
begin
	option := 1;
   tempoAcessoMenu := gettickcount();
   
	menubmp := tbitmap.Create;
   menubmp.width := LARGURA_TELA;
   menubmp.Height := ALTURA_TELA;

   menubmp.Canvas.Brush.Color := clblack;
   menubmp.Canvas.font.Name := 'courier';
   menubmp.canvas.font.size:= 13;

   msg := '';

   while not application.Terminated do
   begin
   	if (GetForegroundWindow = fgame.Handle) then   // checa se janela do jogo tem foco
         if gettickcount() - tempoAcessoMenu > 150 then
         begin
            if getkeystate(vk_down) < 0 then
               if option < 5 then
               begin
                  inc(option);
                  tempoAcessoMenu := gettickcount();
               end;
            if getkeystate(vk_up) < 0 then
               if option > 1 then
               begin
                  dec(option);
                  tempoAcessoMenu := gettickcount();
               end;

            if getkeystate(vk_escape) < 0 then
               begin
                  tempoAcessoMenu := gettickcount();
                  exit;
               end;
            if getkeystate(vk_return) < 0 then
            begin
            	tempoAcessoMenu := gettickcount();
               case option of
                  1:
                  	if nave.crystals >= 30 then
                     begin
                        dec(nave.crystals, 30);
                        nave.energia := MAX_ENERGIA_NAVE;
                        msg := 'Spaceship energy recovered successfully';
                     end
                     else
                        msg := 'Not enough crystals, 30 required.';
                  2: ;
                  4:
                     if nave.crystals >= 350 then
                     begin
                        dec(nave.crystals, 350);
                        nave.sx := nave.sx + 0.5;
                        nave.sy := nave.sy + 0.5;
                        msg := 'Spaceship speed increased by 0.5';
                     end
                     else
                        msg := 'Not enough crystals, 350 required.';
                  5: exit;
               end;
            end;
         end;

   	menubmp.Canvas.FillRect(rect(0,0,LARGURA_TELA,ALTURA_TELA));
      

      if option = 1 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 250, 'Energy recovery - 30 Crystals');
      if option = 2 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 300, 'Temporary shield - 40 Crystals');
      if option = 3 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 350, 'Increase firing power - 45 Crystals');
      if option = 4 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 400, 'Increase speed - 350 Crystals');
      if option = 5 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 450, 'Back');

      menubmp.Canvas.TextOut(20, 30, msg);

      menubmp.Canvas.Brush.color := clblack;

      menubmp.Canvas.Draw(10, 10, fgame.imgCrystal.Picture.Bitmap);
      menubmp.Canvas.TextOut(28, 9, inttostr(nave.crystals));

   	fgame.Canvas.Draw(0, 0, menubmp);
      
   	application.ProcessMessages;
   end;

   menubmp.Free;
	
end;

procedure MenuPrincipal();
var
	menubmp : tbitmap;
   option: byte;
begin
	option := 1;
   tempoAcessoMenu := gettickcount();
   
	menubmp := tbitmap.Create;
   menubmp.width := LARGURA_TELA;
   menubmp.Height := ALTURA_TELA;

   menubmp.Canvas.Brush.Color := clblack;
   menubmp.Canvas.font.Name := 'courier';
   menubmp.canvas.font.size:= 13;

   while not application.Terminated do
   begin
   	if (GetForegroundWindow = fgame.Handle) then   // checa se janela do jogo tem foco
      begin
      	if getkeystate(vk_return) < 0 then
            begin
               case option of
                  1: exit;
                  2: novoJogo();
                  3: if (gettickcount() - tempoAcessoMenu > 150) then MenuUpgrade(); // porque pode-se sair do menu upgrade com a tecla enter!
                  4: salvar();
                  5: carregar();
                  6:	application.Terminate;
               end;
               tempoAcessoMenu := gettickcount();
               if option <> 3 then exit;
         	end;
         if (gettickcount() - tempoAcessoMenu > 150) then
         begin
            if getkeystate(vk_down) < 0 then
               if option < 6 then
               begin
               	tempoAcessoMenu := gettickcount();
               	inc(option);
               end;
            if getkeystate(vk_up) < 0 then
               if option > 1 then
               begin
                  tempoAcessoMenu := gettickcount();
               	dec(option);
               end;

            if getkeystate(vk_escape) < 0 then
            begin
               tempoAcessoMenu := gettickcount();
               exit;
            end;
         end;
      end;
      
   	menubmp.Canvas.FillRect(rect(0,0,LARGURA_TELA,ALTURA_TELA));
      menubmp.Canvas.Brush.Style := bsclear;

      if option = 1 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 200, 'Continue');
      if option = 2 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 250, 'New game');
      if option = 3 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 300, 'Upgrade spaceship');
      if option = 4 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 350, 'Save stage');
      if option = 5 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 400, 'Load stage');
      if option = 6 then menubmp.Canvas.Font.Color := clwhite
      else  menubmp.Canvas.Font.Color := claqua;
      menubmp.Canvas.TextOut(LARGURA_TELA div 2 - 50, 450, 'Quit');

      menubmp.Canvas.Brush.color := clblack;

   	fgame.Canvas.Draw(0, 0, menubmp);

   	application.ProcessMessages;
   end;

   menubmp.Free;
end;

procedure inserirAnimacao(x, y: real; sx, sy : integer; tipo: ttipoanimacao);
var
	i: integer;
begin;
	for i := 1 to MAX_ANIMACOES do
   begin
   	if animacoes[i].ativo = false then
      begin
      	animacoes[i].tipo := tipo;
      	animacoes[i].ativo := true;
      	animacoes[i].frame := 1;
        	animacoes[i].x := trunc(x);
        	animacoes[i].y := trunc(y);

         case tipo of
         	explosao1: animacoes[i].frames := 16;
         end;     
        	break;
      end;
   end;
end;

procedure atualizarAnimacoes();
var
	i: integer;
begin
	if gamecounter mod 3 = 0 then
   begin
   	for i := 1 to MAX_ANIMACOES do
			if animacoes[i].ativo then
         begin
      		if animacoes[i].frame < animacoes[i].frames then
         		Inc(animacoes[i].frame)
         	else
         		animacoes[i].ativo := false;
         end;
   end;
end;

function NegPos(): Integer;
var
	i: byte;
begin
	randomize();
	i:= random(2);
	if i = 0 then Result := 1
   else Result := -1;
end;



procedure adicionarItem(x, y: integer; tipo: ttipoitem);
var
	i : integer;
begin
	for i := 1 to MAX_ITEMS do
  	if not items[i].ativo then
    begin
    	items[i].ativo := true;
      items[i].tipo := tipo;
      items[i].x := x;
      items[i].y := y;
      items[i].largura := 16;
      items[i].altura := 16;
      inserirAnimacao(x - 24, y - 24, 0, 3, newItem);
      break;
    end;
end;

procedure moverItems();
var
	i: integer;
begin
	for i := 1 to MAX_ITEMS do
  		if items[i].ativo then
    	begin
    		items[i].y := items[i].y + 3;
      	if items[i].y >= ALTURA_TELA then items[i].ativo := false;
    	end;
end;

procedure coletarItems();
var
	i: integer;
begin
	randomize();
	for i:= 1 to MAX_ITEMS do
  	if items[i].ativo then
    	if ( (items[i].x + (items[i].largura) >= nave.x)
      	and ( items[i].Y + (items[i].altura) >= nave.y)
        and (items[i].X <= nave.x + LARGURA_NAVE)
        and (items[i].y <= nave.y + ALTURA_NAVE) ) then
        begin
        	items[i].ativo := false;
          case items[i].tipo of
          	powerup:
            begin
            	nave.armas[nave.weaponIndex].nivel := nave.armas[nave.weaponIndex].nivel + 1;
              	enviarmsg('Power up!', clAqua, trunc(nave.x), trunc(nave.y), 0, 3 + random(2), 50);
            end;
            crystal:
            begin
            	nave.crystals := nave.crystals + 1;
              	enviarmsg('+1', clAqua, trunc(nave.x), trunc(nave.y), 0, 3 + random(2), 50);
            end;
            autoTargetWeapon:
            begin
            	nave.armas[2] := ARMA_T2;
               nave.weaponIndex := 2;
            	enviarmsg('Auto targetting missiles!', clAqua, trunc(nave.x), trunc(nave.y), 0, 3 + random(2), 50);
            end;
          end;
        end;
end;

procedure reiniciarJogo();
var
	i: cardinal;
begin
	for i := 1 to nave.crystals do
   	adicionaritem(LARGURA_TELA div 2 + negpos()*random(100), ALTURA_TELA div 2 + negpos()*random(100), crystal);

   nave.crystals := 0;
   nave.weaponIndex := 1;
   nave.energia := MAX_ENERGIA_NAVE;
   Nave.X := LARGURA_TELA div 2 - 30;
   Nave.Y := ALTURA_TELA - ALTURA_NAVE - 30;
end;

procedure inicializarPlanetas();
var
	i: integer;
begin
	randomize();
	for i := 1 to MAX_PLANETAS do
	begin
		planetas[i].speed := 3 + random(5);
    	planetas[i].tipo := 1 + random(9);
      planetas[i].x := random(LARGURA_TELA);
    	planetas[i].y := random(ALTURA_TELA);
  end;
end;

procedure moverPlanetas();
var
	i: integer;
begin
	Randomize();
	for i := 1 to MAX_PLANETAS do
  begin
   	planetas[i].y := planetas[i].y + planetas[i].speed;
   	if planetas[i].y >= ALTURA_TELA then
    begin
    	planetas[i].x := random(LARGURA_TELA);
      planetas[i].y := 0;
   	end;
  end;
end;

procedure inicializarEstrelas();
var
	i: integer;
begin
	for i := 1 to MAX_ESTRELAS do
  begin
  	stars[i].speed := 1 + random(15);
   	stars[i].x := random(LARGURA_TELA);
    stars[i].y := random(ALTURA_TELA);
  end;
end;

procedure moverEstrelas();
var
	i: integer;
begin
	for i := 1 to MAX_ESTRELAS do
  begin
   	stars[i].y := stars[i].y + stars[i].speed;
    if nave.dirx = dirxleft then stars[i].x := stars[i].x + 1 + (stars[i].speed div 5)
    else if nave.dirx = dirxright then stars[i].x := stars[i].x - 1 - (stars[i].speed div 5);
   	if stars[i].y >= ALTURA_TELA then
    begin
    	stars[i].x := random(LARGURA_TELA);
      stars[i].y := 0;
   	end;
    if stars[i].x > LARGURA_TELA then
    begin
    	stars[i].x := 0;
      stars[i].y := random(ALTURA_TELA);
   	end
    else if stars[i].x < 0 then
    begin
    	stars[i].x := LARGURA_TELA;
      stars[i].y := random(ALTURA_TELA);
   	end;
  end;
end;

function giveCrystal(): boolean;
begin
	randomize();
  if random(10) < 5 then Result := true
  else result := false;
end;

function getlarguratiroinimigo(tipotiro : byte):byte;
begin
	getlarguratiroinimigo := LARGURA_TIROS_INIMIGO[tipotiro];
end;

function getalturatiroinimigo(tipotiro : byte):byte;
begin
	getalturatiroinimigo := ALTURA_TIROS_INIMIGO[tipotiro];
end;

function _cos(x2, x1, y2, y1: real): real;
begin
	Result := (x2 - x1) / sqrt( (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) );
end;

function _sin(x2, x1, y2, y1: real): real;
begin
	Result := (y2 - y1) / sqrt( (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) );
end;

function proximoTiroInimigoLivre(): cardinal;
var
	i: cardinal;
begin
	for i := 1 to MAX_TIROS_INIMIGO do
  	if not tiros_inimigo[i].ativo then
    begin
    	result := i;
      exit;
    end;

  result := 0;
end;

function proximoInimigoLivre(): cardinal;
var
	i: cardinal;
begin
	for i := 1 to MAX_INIMIGOS do
  	if not inimigos[i].ativo then
    begin
    	result := i;
      exit;
    end;

  result := 0;
end;

function getPoderTiroInimigo(tipotiro : byte): byte;
begin
	result := 1;
end;

procedure InimigoAtira(inimigo_id: cardinal; x, y, sx, sy: real; tipoTiro : byte);
var
	t : integer;
begin
   t := proximoTiroInimigoLivre();
   if t = 0 then exit;
   tiros_inimigo[t].Tipo := tipoTiro;
   tiros_inimigo[t].poder := getPoderTiroInimigo(tipoTiro);
   tiros_inimigo[t].ativo:= true;
   tiros_inimigo[t].largura := getlarguratiroinimigo(tipoTiro);
   tiros_inimigo[t].altura := getalturatiroinimigo(tipoTiro);
   tiros_inimigo[t].X := x;
   tiros_inimigo[t].Y := y;
   tiros_inimigo[t].sx := sx;
   tiros_inimigo[t].sy := sy;
   tiros_inimigo[t].frame := 1;

   case tipotiro of
   	1: tiros_inimigo[t].frames := 2
      else tiros_inimigo[t].frames := 1;
   end;

end;

procedure MoverTirosInimigo();
var
	i : cardinal;
begin
	for i:= 1 to MAX_TIROS_INIMIGO do
   begin
   	if tiros_inimigo[i].ativo then
      begin
      	tiros_inimigo[i].y := tiros_inimigo[i].y + tiros_inimigo[i].sy;
        tiros_inimigo[i].x := tiros_inimigo[i].x + tiros_inimigo[i].sx;
        if tiros_inimigo[i].Y >= ALTURA_TELA + 100 then tiros_inimigo[i].Ativo := false
        else if tiros_inimigo[i].Y + tiros_inimigo[i].altura <= -100 then tiros_inimigo[i].Ativo := false;
        if tiros_inimigo[i].x >= LARGURA_TELA + 100 then tiros_inimigo[i].Ativo := false
        else if tiros_inimigo[i].x + tiros_inimigo[i].largura <= -100 then tiros_inimigo[i].Ativo := false
      end;
   end;
end;

procedure novaFase();
begin
	inc(fase);
   posicaosubfase := 0;
   subfase := 1;
   salvarDadosJogo();
end;

procedure verificarDanosNoInimigo();
var
	i, j, k : integer;
begin
	randomize();
	for i := 1 to MAX_TIROS_NAVE do
	begin
  	if tirosnave[i].ativo then
    begin
      	for j := 1 to MAX_INIMIGOS do
        begin
         	if Inimigos[j].ativo then
          begin
          	if (tirosnave[i].X + nave.armas[nave.weaponIndex].largura >= Inimigos[j].x)
          		and ((tirosnave[i].x <= Inimigos[j].x + inimigos[j].largura))
              and (tirosnave[i].Y <= Inimigos[j].Y + (4/5) * (inimigos[j].altura))
              and (tirosnave[i].Y + nave.armas[nave.weaponIndex].altura >= Inimigos[j].Y) then
            begin
            	tirosnave[i].ativo := false;
              Inimigos[j].energia := inimigos[j].energia - nave.armas[nave.weaponIndex].damage;
              case tirosnave[i].arma.tipo of
              	t1,t3,t4,t5: inserirAnimacao(tirosnave[i].x + NegPos() * Random(20), tirosnave[i].y + NegPos() * Random(20), 0, 0, explosao2);
               t2: inserirAnimacao(tirosnave[i].x + NegPos() * Random(20), tirosnave[i].y + NegPos() * Random(20), 0, 0, explosao1);
              end;

              if inimigos[j].energia <= 0 then
              begin
              	inc(score);
              	if giveCrystal() then AdicionarItem(trunc(inimigos[j].x), trunc(inimigos[j].y), crystal);

              	case inimigos[j].tipo of
                	alien:
                  begin
                  	InserirAnimacao(inimigos[j].x + random(inimigos[j].largura), inimigos[j].y + random(inimigos[j].altura), 0, 0, explosao1);
                  	InserirAnimacao(inimigos[j].x + random(inimigos[j].largura), inimigos[j].y + random(inimigos[j].altura), 0, 0, explosao1);
                  	InserirAnimacao(inimigos[j].x + random(inimigos[j].largura), inimigos[j].y + random(inimigos[j].altura), 0, 0, explosao1);
                  	InserirAnimacao(inimigos[j].x + random(inimigos[j].largura), inimigos[j].y + random(inimigos[j].altura), 0, 0, explosao1);
                  end;
                  viper:
                  begin
                  	InserirAnimacao(trunc(inimigos[j].x) + random(inimigos[j].largura), trunc(inimigos[j].y) + random(inimigos[j].altura), 0, 0, explosao1);
                    InserirAnimacao(trunc(inimigos[j].x) + random(inimigos[j].largura), trunc(inimigos[j].y) + random(inimigos[j].altura), 0, 0, explosao1);
                  end;
                  selfDestructor:
                  	InserirAnimacao(trunc(inimigos[j].x) + random(inimigos[j].largura), trunc(inimigos[j].y) + random(inimigos[j].altura), 0, 0, explosao3);
                  Boss1:
                  begin
                  	for k := 1 to 20 do
                    		InserirAnimacao(trunc(inimigos[j].x) + random(inimigos[j].largura), trunc(inimigos[j].y) + random(inimigos[j].altura), 0, 0, explosao1);
                    enviarmsg('Report: Enemy destroyed, well done!', clAqua, 0, 0, 0, 0, 300);

                    adicionaritem(LARGURA_TELA div 2 + negpos() * random(100), 100 + random(50), powerup);
                    for k := 1 to 20 do
                    		adicionaritem(LARGURA_TELA div 2 + negpos() * random(100), 100 + negpos() * random(50), crystal);
                    novafase();
                    bosstime := false;
                  end;
                end;
              	inimigos[j].ativo := false;
              end;
              break;
            end;
          end;
        end;
      end;
	end;
end;

procedure AdicionarInimigo(Tipo: TTipoInimigo; x, y: real; boss: boolean);
var
	i: integer;
begin
	Randomize();
	for i := 1 to MAX_INIMIGOS do
  begin
		if Inimigos[i].ativo = false then
    begin
    	inimigos[i].boss := boss;
    	Inimigos[i].Ativo := true;
      Inimigos[i].Tipo := Tipo;
      Inimigos[i].x := x;
      Inimigos[i].y := y;
			case Tipo of
      	Alien:
        begin
        	inimigos[i].energia := 2;
      		Inimigos[i].largura := fGame.imgAlien.Width;
          Inimigos[i].altura := fGame.imgAlien.Height;
          inimigos[i].sy := 1 + random(2);
        end;
      	Viper:
        begin
        	inimigos[i].energia := 1;
        	Inimigos[i].largura := fGame.imgViper.Width;
          Inimigos[i].altura := fGame.imgViper.Height;
          inimigos[i].sy := 5 + random(4);
          if inimigos[i].x <= (LARGURA_TELA div 2) then
          	inimigos[i].sx := 1 + Random(4)
          else
          	inimigos[i].sx := - 1 - Random(4);
        end;
        Boss1:
        begin
        	inimigos[i].energia := 300;
        	Inimigos[i].largura := fGame.imgBoss1.Width;
          Inimigos[i].altura := fGame.imgBoss1.Height - 20;
        end;
        selfDestructor:
        begin
        	inimigos[i].energia := 1;
          inimigos[i].sy := 3 * _sin(nave.x, inimigos[i].x, nave.y, inimigos[i].y);
          inimigos[i].sx := 3 * _cos(nave.x, inimigos[i].x, nave.y, inimigos[i].y);
        	Inimigos[i].largura := fGame.imgSelfDestruct.Width;
          Inimigos[i].altura := fGame.imgSelfDestruct.Height;
        end;
      end;
      exit;
    end;
	end;
end;

procedure MoverInimigos();
var
	i: integer;
  tiro_cos, tiro_sin : real;
begin
   for i := 1 to MAX_INIMIGOS do
   begin
   	if Inimigos[i].ativo = true then
      begin
      	tiro_cos := _cos(nave.x + LARGURA_NAVE div 2, inimigos[i].x + inimigos[i].largura div 2, nave.y + ALTURA_NAVE div 2, inimigos[i].y + inimigos[i].altura div 2);
        	tiro_sin := _sin(nave.x + LARGURA_NAVE div 2, inimigos[i].x + inimigos[i].largura div 2, nave.y + ALTURA_NAVE div 2, inimigos[i].y + inimigos[i].altura div 2);

      	case Inimigos[i].Tipo of
         	Alien:
            begin
            	Inimigos[i].y := Inimigos[i].y + inimigos[i].sy;
        			Inimigos[i].x := Inimigos[i].x + 3 * sin(Inimigos[i].y / 40);
              	if (trunc(inimigos[i].y) mod 100) = 0 then inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + inimigos[i].altura div 2, negpos() * (2 + random(3)),{11 * tiro_cos}4 + random(4){11 * tiro_sin}, 1);
        			if Inimigos[i].y >= ALTURA_TELA then Inimigos[i].ativo := false;
            end;

            Viper:
            begin
            	Inimigos[i].y := Inimigos[i].y + inimigos[i].sy;
              	Inimigos[i].x := Inimigos[i].x + inimigos[i].sx;
              if (trunc(inimigos[i].y) mod 70) = 0 then inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + inimigos[i].altura div 2, 10 * tiro_cos, 10 * tiro_sin, 2);
        			if Inimigos[i].y >= ALTURA_TELA then Inimigos[i].ativo := false;
            end;

            selfDestructor:
            begin
            	Inimigos[i].y := Inimigos[i].y + inimigos[i].sy;
              	Inimigos[i].x := Inimigos[i].x + inimigos[i].sx;
              	if Inimigos[i].y >= ALTURA_TELA + OFFSCREEN then Inimigos[i].ativo := false
               else if inimigos[i].y + inimigos[i].altura <= -OFFSCREEN then inimigos[i].ativo := false;
              	if Inimigos[i].x >= LARGURA_TELA + OFFSCREEN then Inimigos[i].ativo := false
              	else if Inimigos[i].x + inimigos[i].largura <=0 then Inimigos[i].ativo := false;
              
               if (posicaosubfase mod 100) = 0 then
               begin
            		InserirAnimacao(trunc(inimigos[i].x), trunc(inimigos[i].y), 0, 0, explosao3);
                  inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + (inimigos[i].altura div 2), negpos()*(random(10)), 13, 5);
                  inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + (inimigos[i].altura div 2), negpos()*(random(11)), 11, 5);
                  inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + (inimigos[i].altura div 2), negpos()*(random(12)), 12, 5);
                  inimigos[i].ativo := false;
					end;
            end;

            Boss1:
            begin
            	if inimigos[i].y + (inimigos[i].altura div 2) < (nave.y + ALTURA_NAVE div 2) then inimigos[i].y := inimigos[i].y + 0.25
              else if inimigos[i].y + (inimigos[i].altura div 2) > (nave.y + ALTURA_NAVE div 2) then inimigos[i].y := inimigos[i].y - 1;
              inimigos[i].x := (LARGURA_TELA div 2) - (inimigos[i].largura div 2) + (LARGURA_TELA div 2) * sin(gamecounter / 90);

              if PosicaoSubFase mod 50 = 0 then
              begin
              		inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + (inimigos[i].altura div 2), 8 * tiro_cos, 8 * tiro_sin, 1);
                	inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + (inimigos[i].altura div 2), 10 * tiro_cos, 10 * tiro_sin, 1);
              end;
              if PosicaoSubFase mod 90 = 0 then inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 2), inimigos[i].y + (inimigos[i].altura div 2), 10 * tiro_cos, 10 * tiro_sin, 1);

              if (PosicaoSubFase mod 200 = 0) or (PosicaoSubFase mod 202 = 0) or (PosicaoSubFase mod 204 = 0) or (PosicaoSubFase mod 206 = 0) then
              begin
						tiro_cos := _cos(nave.x + LARGURA_NAVE div 2, inimigos[i].x + inimigos[i].largura div 4, nave.y + ALTURA_NAVE div 2, inimigos[i].y + inimigos[i].altura);
               	tiro_sin := _sin(nave.x + LARGURA_NAVE div 2, inimigos[i].x + inimigos[i].largura div 4, nave.y + ALTURA_NAVE div 2, inimigos[i].y + inimigos[i].altura);
              		inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 4), inimigos[i].y + (inimigos[i].altura), 20 * tiro_cos, 20 * tiro_sin, 7);

                	tiro_cos := _cos(nave.x + LARGURA_NAVE div 2, inimigos[i].x + (3/4) * inimigos[i].largura, nave.y + ALTURA_NAVE div 2, inimigos[i].y + inimigos[i].altura);
                	tiro_sin := _sin(nave.x + LARGURA_NAVE div 2, inimigos[i].x + (3/4) * inimigos[i].largura, nave.y + ALTURA_NAVE div 2, inimigos[i].y + inimigos[i].altura);
              		inimigoatira(i, inimigos[i].x + (3/4) * (inimigos[i].largura), inimigos[i].y + inimigos[i].altura, 20 * tiro_cos, 20 * tiro_sin, 7);
              end;
              if PosicaoSubFase mod 70 = 0 then
          			AdicionarInimigo(selfDestructor, Inimigos[i].x + Inimigos[i].largura div 2, Inimigos[i].y + (Inimigos[i].altura div 2), false);

              if inimigos[i].energia < 100 then
              begin
              	if PosicaoSubFase mod 30 = 0 then
          			AdicionarInimigo(selfDestructor, Inimigos[i].x + Inimigos[i].largura div 2, Inimigos[i].y + (Inimigos[i].altura div 2), false);

               if posicaosubfase mod 200 = 0 then
               begin
               	inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 4) - 10, inimigos[i].y + inimigos[i].altura, 0, 8, 4);
                  inimigoatira(i, inimigos[i].x + (inimigos[i].largura div 4) + 25, inimigos[i].y + inimigos[i].altura, 0, 9, 4);
                  inimigoatira(i, inimigos[i].x + (3/4)*(inimigos[i].largura) - 10, inimigos[i].y + inimigos[i].altura, 0, 9, 4);
                  inimigoatira(i, inimigos[i].x + (3/4)*(inimigos[i].largura) + 20, inimigos[i].y + inimigos[i].altura, 0, 8, 4);
               end;

              	enviarmsg('Remaining energy: ' + inttostr(inimigos[i].energia), claqua, 0, 0, 0, 0, 1);
              	if trunc(inimigos[i].x) mod 10 = 0 then
                	begin
              			InserirAnimacao(trunc(inimigos[i].x) + random(inimigos[i].largura), trunc(inimigos[i].y) + random(inimigos[i].altura), 0, 0, explosao1);
                  	if inimigos[i].energia <= 50 then
                    		InserirAnimacao(trunc(inimigos[i].x) + random(inimigos[i].largura), trunc(inimigos[i].y) + random(inimigos[i].altura), 0, 0, explosao1);
                  end;
              end;
            end;
         end;
      end;
   end;
end;

function procurarInimigoAtivo(): cardinal;
var
	i, j, k : cardinal;
begin
	randomize();

	j := 0;
   for i := 1 to MAX_INIMIGOS do
   	if inimigos[i].ativo then
      	j := i;
   if j = 0 then
   begin
      result := 0;
   	exit;
   end
   else
   begin
      repeat
         k := 1 + random(MAX_INIMIGOS)
      until inimigos[k].ativo;

      result := k;
   end;
end;

function nomeArma(): string;
begin
	case nave.armas[nave.weaponIndex].tipo of
   	t1: result := 'plasma weapon';
      t2: result := 'auto targetting missiles';
      t3: result := 't3';
      t4: result := 't4';
      t5: result := 't5';
   end;
end;

procedure naveAtira();
var
	i, j : integer;
begin
	randomize();
	for j := 1 to nave.armas[nave.weaponIndex].nivel do
      if nave.armas[nave.weaponIndex].municao > 0 then
         for i:= 1 to MAX_TIROS_NAVE do
            if tirosnave[i].Ativo = false then
            begin
               tirosnave[i].arma := nave.armas[nave.weaponIndex];
               tirosnave[i].ativo:= true;
               tirosnave[i].sx := 0;
               tirosnave[i].frame := 1;
               dec(nave.armas[nave.weaponIndex].municao);

               case nave.armas[nave.weaponIndex].tipo of
                  t1,t3,t4,t5:
                  begin
                  	tirosnave[i].sy := 10;
                     tirosnave[i].X := nave.x + (LARGURA_NAVE div 2) - 4 + 2 * negpos() * Random(2 * nave.armas[nave.weaponIndex].nivel);
                     tirosnave[i].y := nave.y + negpos() * random(ALTURA_NAVE);
                     nave.armas[nave.weaponIndex].tempoCarregamento := ARMA_T1.tempoCarregamento;
                  end;
                  t2:
                  begin
                  	tirosnave[i].accel := 0.1;
                  	tirosnave[i].sy := -0.5;
                     tirosnave[i].sx := 0;
                     tirosnave[i].speed := 5;
                     tirosnave[i].X := nave.x + (LARGURA_NAVE div 2) - 4 + 2 * negpos() * Random(2 * nave.armas[nave.weaponIndex].nivel);
                     tirosnave[i].y := nave.y + random(ALTURA_NAVE);
                     nave.armas[2].tempoCarregamento := ARMA_T2.tempoCarregamento;
                     tirosnave[i].lockonID := procurarInimigoAtivo();
                  end;
               end;
            	break;
            end;
end;

procedure especial();
var
	i: cardinal;
begin
	for i := 1 to 50 do
   	naveatira();
end;

procedure lerTeclado();
begin

   if gettickcount - tempoAcessoMenu > 250 then
   	if getkeystate(vk_escape) < 0 then MenuPrincipal();

	Nave.dirx := dirxnil;
  	nave.diry := dirynil;

	if GetKeyState(vk_left) < 0 then Nave.dirx := dirxleft;
	if GetKeyState(vk_right) < 0 then Nave.dirx := dirxright;

	if GetKeyState(vk_up) < 0 then nave.diry := diryup;
  	if GetKeyState(vk_down) < 0 then nave.diry := dirydown;

   if getkeystate($31) < 0 then nave.weaponIndex := 1
   else if getkeystate($32) < 0 then nave.weaponIndex := 2
   else if getkeystate($33) < 0 then nave.weaponIndex := 3
   else if getkeystate($34) < 0 then nave.weaponIndex := 4
   else if getkeystate($35) < 0 then nave.weaponIndex := 5;

	if getkeystate(vk_f1) < 0 then Salvar();

	if nave.armas[nave.weaponIndex].tempoCarregamento = 0 then
		if GetKeyState(vk_control) < 0 then	naveatira();

   if nave.tempoCarregamentoEspecial = 0 then
   	if getkeystate(vk_shift) < 0 then especial();
end;

procedure TfGame.FormDestroy(Sender: TObject);
begin
	backbuffer.Free;
   SetScreenResolution(oldwidth, oldheight, 32);
   ShowCursor(True);
end;

procedure desenhar(x, y : real; bitmap : tbitmap);
begin
	backbuffer.canvas.draw(trunc(x), trunc(y), bitmap);
end;

procedure DesenharJogo();
var
	i: integer;
begin
	BackBuffer.Canvas.FillRect(Rect(0, 0, LARGURA_TELA, ALTURA_TELA));

  for i := 1 to MAX_PLANETAS do
  	case planetas[i].tipo of
    	1:	desenhar(planetas[i].x, planetas[i].y, fgame.c1.Picture.Bitmap);
      2:	desenhar(planetas[i].x, planetas[i].y, fgame.c2.Picture.Bitmap);
      3:	desenhar(planetas[i].x, planetas[i].y, fgame.c3.Picture.Bitmap);
      4:	desenhar(planetas[i].x, planetas[i].y, fgame.c4.Picture.Bitmap);
      5:	desenhar(planetas[i].x, planetas[i].y, fgame.c5.Picture.Bitmap);
      6:	desenhar(planetas[i].x, planetas[i].y, fgame.c6.Picture.Bitmap);
      7:	desenhar(planetas[i].x, planetas[i].y, fgame.c7.Picture.Bitmap);
      8:	desenhar(planetas[i].x, planetas[i].y, fgame.c8.Picture.Bitmap);
    end;

	for i := 1 to MAX_ESTRELAS do
		BackBuffer.Canvas.Pixels[trunc(stars[i].x), trunc(stars[i].y)] := clWhite;

	for i:=1 to MAX_INIMIGOS do
      begin
       	if Inimigos[i].ativo then
        begin
         	case Inimigos[i].Tipo of
           		Alien:
               	desenhar(Inimigos[i].x, Inimigos[i].Y, fgame.imgAlien.Picture.bitmap);
               Viper:
               	desenhar(Inimigos[i].x, Inimigos[i].Y, fgame.imgViper.Picture.bitmap);
               Boss1:
               	desenhar(Inimigos[i].x, Inimigos[i].Y, fgame.imgBoss1.Picture.bitmap);

               selfDestructor:
               	desenhar(Inimigos[i].x, Inimigos[i].Y, fgame.imgSelfDestruct.Picture.bitmap);
         end;
         //backbuffer.Canvas.TextOut(trunc(Inimigos[i].x), trunc(Inimigos[i].Y), inttostr(inimigos[i].energia));
        end;
      end;

      for i:=1 to MAX_TIROS_INIMIGO do
      begin
       	if tiros_inimigo[i].ativo = true then
         	case tiros_inimigo[i].Tipo of
          	1:
            	case tiros_inimigo[i].frame of
               	1: desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgti1_1.Picture.bitmap);
                  2: desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgti1_2.Picture.bitmap);
               end;
            2:
               	desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgT2.Picture.bitmap);
            3:
               	desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgSelfDestruct.Picture.bitmap);
            4:
               	desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgT4.Picture.bitmap);
            5:
               	desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgT5.Picture.bitmap);
            7:
               	desenhar(tiros_inimigo[i].x, tiros_inimigo[i].Y, fgame.imgt7_1.Picture.bitmap);
            end;
      end;

   for i := 1 to MAX_TIROS_NAVE do
   	if tirosnave[i].ativo = true then
      begin
      	case tirosnave[i].arma.tipo of
         	t1,t3,t4,t5:
            	case tirosnave[i].frame of
               	1: desenhar(tirosnave[i].x, tirosnave[i].Y, fgame.imgtn1_1.Picture.bitmap);
                  2: desenhar(tirosnave[i].x, tirosnave[i].Y, fgame.imgtn1_2.Picture.bitmap);
               end;
            t2:
               if tirosnave[i].lockonID = 0 then
               case tirosnave[i].frame of
               	1: desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket6_1.picture.bitmap);
                  2: desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket6_2.picture.bitmap);
                  3: desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket6_3.picture.bitmap);
               end
               else
               begin
                  //12
                  if (tirosnave[i].x >= inimigos[tirosnave[i].lockonID].x - tirosnave[i].arma.largura)
                     and (tirosnave[i].y <= inimigos[tirosnave[i].lockonID].y)
                     and (tirosnave[i].x + tirosnave[i].arma.largura <= inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura + tirosnave[i].arma.largura) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket12.picture.bitmap)
                  // 1..2
                  else if (tirosnave[i].x > inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura)
                     and (tirosnave[i].y + tirosnave[i].arma.altura < inimigos[tirosnave[i].lockonID].y) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket1to2.picture.bitmap)
                  //  3
                  else if (tirosnave[i].x >= inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura)
                     and (tirosnave[i].y >= inimigos[tirosnave[i].lockonID].y - tirosnave[i].arma.altura)
                     and (tirosnave[i].y + tirosnave[i].arma.altura <= inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura + tirosnave[i].arma.altura) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket3.picture.bitmap)
                  // 4..5
                  else if (tirosnave[i].x > inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura)
                     and (tirosnave[i].y > inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket4to5.picture.bitmap)
                  // 6
                  else if (tirosnave[i].x >= inimigos[tirosnave[i].lockonID].x - tirosnave[i].arma.largura)
                     and (tirosnave[i].y >= inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura)
                     and (tirosnave[i].x + tirosnave[i].arma.largura <= inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura + tirosnave[i].arma.largura) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket6_1.picture.bitmap)
                  // 7..8
                  else if (tirosnave[i].x + tirosnave[i].arma.largura < inimigos[tirosnave[i].lockonID].x)
                     and (tirosnave[i].y > inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket7to8.picture.bitmap)
                  // 9
                  else if (tirosnave[i].x + tirosnave[i].arma.largura <= inimigos[tirosnave[i].lockonID].x)
                     and (tirosnave[i].y >= inimigos[tirosnave[i].lockonID].y - tirosnave[i].arma.altura)
                     and (tirosnave[i].y + tirosnave[i].arma.altura <= inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura + tirosnave[i].arma.altura) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket9.picture.bitmap)
                  // 10..11
                  else if (tirosnave[i].x + tirosnave[i].arma.largura < inimigos[tirosnave[i].lockonID].x)
                     and (tirosnave[i].y + tirosnave[i].arma.altura < inimigos[tirosnave[i].lockonID].y) then
                        desenhar(trunc(tirosnave[i].x), trunc(tirosnave[i].y), fgame.imgRocket10to11.picture.bitmap);
               end;
         end;
      end;

  if nave.shield then
  	desenhar(Nave.X - 7, Nave.Y, fgame.imgshield.Picture.Bitmap);

    for i := 1 to MAX_ITEMS do
   		if items[i].ativo = true then
      	case items[i].tipo of
        		powerup:
    				desenhar(items[i].x, trunc(items[i].Y), fgame.imgItempowerup.Picture.bitmap);
          	crystal:
          		desenhar(items[i].x, trunc(items[i].Y), fgame.imgCrystal.Picture.bitmap);
            autoTargetWeapon:
          		desenhar(items[i].x, trunc(items[i].Y), fgame.imgItempowerup.Picture.bitmap);
        end;


	if Nave.dirx = dirxleft then
   	case nave.frame of
      	1: desenhar(Nave.X, Nave.Y, fgame.imgnaveleftfull.Picture.Bitmap);
         2: desenhar(Nave.X, Nave.Y, fgame.imgnaveleft.Picture.Bitmap);
      end
   else if Nave.dirx = dirxright then
   	case nave.frame of
      	1: desenhar(Nave.X, Nave.Y, fgame.imgnaverightfull.Picture.Bitmap);
         2: desenhar(Nave.X, Nave.Y, fgame.imgnaveright.Picture.Bitmap);
      end
   else
   begin
   	case nave.frame of
      	1: desenhar(Nave.X, Nave.Y, fgame.imgnave.Picture.Bitmap);
         2: desenhar(Nave.X, Nave.Y, fgame.imgNavefull.Picture.Bitmap);
      end;
   end;

	for i:= 1 to MAX_ANIMACOES do
      if animacoes[i].ativo then
       begin
         case animacoes[i].tipo of
            explosao1:
               case animacoes[i].frame of
                  1: desenhar(animacoes[i].x, animacoes[i].y, fgame.e1.Picture.Bitmap);
                  2: desenhar(animacoes[i].x, animacoes[i].y, fgame.e2.Picture.Bitmap);
                  3: desenhar(animacoes[i].x, animacoes[i].y, fgame.e3.Picture.Bitmap);
                  4: desenhar(animacoes[i].x, animacoes[i].y, fgame.e4.Picture.Bitmap);
                  5: desenhar(animacoes[i].x, animacoes[i].y, fgame.e5.Picture.Bitmap);
                  6: desenhar(animacoes[i].x, animacoes[i].y, fgame.e6.Picture.Bitmap);
                  7: desenhar(animacoes[i].x, animacoes[i].y, fgame.e7.Picture.Bitmap);
                  8: desenhar(animacoes[i].x, animacoes[i].y, fgame.e8.Picture.Bitmap);
                  9: desenhar(animacoes[i].x, animacoes[i].y, fgame.e9.Picture.Bitmap);
                  10: desenhar(animacoes[i].x, animacoes[i].y, fgame.e10.Picture.Bitmap);
                  11: desenhar(animacoes[i].x, animacoes[i].y, fgame.e11.Picture.Bitmap);
                  12: desenhar(animacoes[i].x, animacoes[i].y, fgame.e12.Picture.Bitmap);
                  13: desenhar(animacoes[i].x, animacoes[i].y, fgame.e13.Picture.Bitmap);
                  14: desenhar(animacoes[i].x, animacoes[i].y, fgame.e14.Picture.Bitmap);
                  15: desenhar(animacoes[i].x, animacoes[i].y, fgame.e15.Picture.Bitmap);
                  16: desenhar(animacoes[i].x, animacoes[i].y, fgame.e16.Picture.Bitmap);
                end;

           explosao2:
            case animacoes[i].frame of
               1: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx1.Picture.Bitmap);
               2: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx2.Picture.Bitmap);
               3: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx3.Picture.Bitmap);
               4: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx4.Picture.Bitmap);
               5: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx5.Picture.Bitmap);
               6: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx6.Picture.Bitmap);
               7: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx7.Picture.Bitmap);
               8: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEx8.Picture.Bitmap);
             end;

           explosao3:
            case animacoes[i].frame of
               1: desenhar(animacoes[i].x, animacoes[i].y, fgame.f1.Picture.Bitmap);
               2: desenhar(animacoes[i].x, animacoes[i].y, fgame.f2.Picture.Bitmap);
               3: desenhar(animacoes[i].x, animacoes[i].y, fgame.f3.Picture.Bitmap);
               4: desenhar(animacoes[i].x, animacoes[i].y, fgame.f4.Picture.Bitmap);
               5: desenhar(animacoes[i].x, animacoes[i].y, fgame.f5.Picture.Bitmap);
               6: desenhar(animacoes[i].x, animacoes[i].y, fgame.f6.Picture.Bitmap);
               7: desenhar(animacoes[i].x, animacoes[i].y, fgame.f7.Picture.Bitmap);
               8: desenhar(animacoes[i].x, animacoes[i].y, fgame.f8.Picture.Bitmap);
             end;

            newItem:
               case animacoes[i].frame of
                  1: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial1.Picture.Bitmap);
                  2: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial2.Picture.Bitmap);
                  3: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial3.Picture.Bitmap);
                  4: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial4.Picture.Bitmap);
                  5: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial5.Picture.Bitmap);
                  6: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial6.Picture.Bitmap);
                  7: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial7.Picture.Bitmap);
                  8: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial8.Picture.Bitmap);
                  9: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial9.Picture.Bitmap);
                  10: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial10.Picture.Bitmap);
                  11: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial11.Picture.Bitmap);
                  12: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial12.Picture.Bitmap);
                  13: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial13.Picture.Bitmap);
                  14: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial14.Picture.Bitmap);
                  15: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial15.Picture.Bitmap);
                  16: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgspecial16.Picture.Bitmap);
                end;

            target:
               case animacoes[i].frame of
                  1: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget1.Picture.Bitmap);
                  2: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget1.Picture.Bitmap);
                  3: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget1.Picture.Bitmap);
                  4: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget2.Picture.Bitmap);
                  5: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget2.Picture.Bitmap);
                  6: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget2.Picture.Bitmap);
                  7: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget3.Picture.Bitmap);
                  8: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget3.Picture.Bitmap);
                  9: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgTarget3.Picture.Bitmap);
               end;

            lightning:
               case animacoes[i].frame of
                  1: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial1.Picture.Bitmap);
                  2: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial2.Picture.Bitmap);
                  3: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial3.Picture.Bitmap);
                  4: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial4.Picture.Bitmap);
                  5: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial1.Picture.Bitmap);
                  6: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial2.Picture.Bitmap);
                  7: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial3.Picture.Bitmap);
                  8: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial4.Picture.Bitmap);
                  9: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial1.Picture.Bitmap);
                  10: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial2.Picture.Bitmap);
                  11: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial3.Picture.Bitmap);
                  12: desenhar(animacoes[i].x, animacoes[i].y, fgame.imgEspecial4.Picture.Bitmap);
               end;
         end;
         //backbuffer.canvas.textout(trunc(animacoes[i].x), animacoes[i].y, inttostr(animacoes[i].frame));
    end;

	if nave.energia < 50 then
   	backbuffer.Canvas.Brush.Color := clred
   else
   	backbuffer.Canvas.Brush.Color := claqua;

   backbuffer.Canvas.Rectangle(Rect(0, ALTURA_TELA - 10, trunc(LARGURA_TELA * nave.energia / MAX_ENERGIA_NAVE), ALTURA_TELA + 10));
   backbuffer.Canvas.Brush.Color := clblack;


   backbuffer.Canvas.Brush.Style := bsclear;
	Backbuffer.Canvas.TextOut(20, ALTURA_TELA - 29, inttostr(Nave.crystals));
	desenhar(3, ALTURA_TELA - 28, fgame.imgCrystal.Picture.Bitmap);

   backbuffer.Canvas.TextOut(3, ALTURA_TELA - 130, 'scr:' + inttostr(score));

   backbuffer.Canvas.TextOut(3, ALTURA_TELA - 115, 'loading ' + inttostr(nave.armas[nave.weaponIndex].tempoCarregamento));
   backbuffer.Canvas.TextOut(3, ALTURA_TELA - 100, nomeArma());
   backbuffer.Canvas.TextOut(3, ALTURA_TELA - 85, 'amm: ' + inttostr(nave.armas[nave.weaponIndex].municao));
   backbuffer.Canvas.TextOut(3, ALTURA_TELA - 70, 'lvl: ' + inttostr(nave.armas[nave.weaponIndex].nivel));
   backbuffer.Canvas.TextOut(3, ALTURA_TELA - 55, 'dmg: ' + inttostr(nave.armas[nave.weaponIndex].damage));

   backbuffer.canvas.textout(LARGURA_TELA - 200, ALTURA_TELA - 30, inttostr(fase) + ':' +  inttostr(subfase) + ':' + inttostr(PosicaoSubFase) + ':' + inttostr(gameCounter) + '  FPS: ' + inttostr(fps));

  // prints all msg's

  for i := 1 to MAX_MSG do
    if mensagens[i].ativo then
      if mensagens[i].tempo > 0 then
      begin
      	backbuffer.Canvas.font.Color := mensagens[i].cor;
        backbuffer.canvas.TextOut(mensagens[i].x, mensagens[i].y, mensagens[i].mensagem);
        backbuffer.Canvas.font.Color := claqua;
        dec(mensagens[i].tempo);
      end
      else if mensagens[i].tempo <= 0 then
        mensagens[i].ativo := false;

	moverMensagens();

  backbuffer.Canvas.Brush.Color:=clblack;
end;

procedure detectarColisaoComInimigo();
var
	i: integer;
begin
	for i:= 1 to MAX_INIMIGOS do
   begin
		if Inimigos[i].ativo then
      begin
      	if ( (Inimigos[i].x + (Inimigos[i].largura) >= nave.x)
        	and ( Inimigos[i].Y + (Inimigos[i].altura) >= nave.y)
        	and (Inimigos[i].X <= nave.x + LARGURA_NAVE)
          and (Inimigos[i].y <= nave.y + ALTURA_NAVE) ) then
        begin
        	InserirAnimacao(trunc(nave.x) + NegPos() * random(LARGURA_NAVE), Trunc(nave.y) + NegPos() * random(ALTURA_NAVE), 0, 0, explosao1);
          if PosicaoSubFase mod 10 = 0 then nave.energia := nave.energia - 1;
          if not inimigos[i].boss then inimigos[i].energia := inimigos[i].energia - 1;
          if inimigos[i].energia <= 0 then
          begin
            Inimigos[i].ativo := false;
            InserirAnimacao(trunc(inimigos[i].x) + random(inimigos[i].largura), Trunc(inimigos[i].y) + random(inimigos[i].altura), 0, 0, explosao1);
            InserirAnimacao(trunc(inimigos[i].x) + random(inimigos[i].largura), Trunc(inimigos[i].y) + random(inimigos[i].altura), 0, 0, explosao1);
            InserirAnimacao(trunc(inimigos[i].x) + random(inimigos[i].largura), Trunc(inimigos[i].y) + random(inimigos[i].altura), 0, 0, explosao1);
            InserirAnimacao(trunc(inimigos[i].x) + random(inimigos[i].largura), Trunc(inimigos[i].y) + random(inimigos[i].altura), 0, 0, explosao1);
          end;
          if (nave.energia <= 0) then reiniciarJogo();
         end;
      end;
   end;
end;


procedure detectarDanosNaNave();
var
	i : cardinal;
begin
	randomize();
	for i:= 1 to MAX_TIROS_INIMIGO do
   begin
		if tiros_inimigo[i].ativo then
      begin
      	if ( (tiros_inimigo[i].x + tiros_inimigo[i].largura >= nave.x)
         	and ( tiros_inimigo[i].Y + tiros_inimigo[i].altura >= nave.y)
         	and (tiros_inimigo[i].X <= nave.x + LARGURA_NAVE)
            and (tiros_inimigo[i].y <= nave.y + ALTURA_NAVE) ) then
         begin
            if not nave.shield then	nave.energia := nave.energia - tiros_inimigo[i].poder;
            enviarmsg('-' + inttostr(tiros_inimigo[i].poder), clRed, trunc(nave.x), trunc(nave.y), 0, 3, 50);
            tiros_inimigo[i].ativo := false;
            InserirAnimacao(trunc(tiros_inimigo[i].x) + negpos() * random(10), Trunc(tiros_inimigo[i].Y) + negpos() * random(10), 0, 0, explosao1);
            if (nave.energia <= 0) then reiniciarJogo();
         end;
      end;
   end;
end;

procedure movernave();
begin
	if nave.dirx = dirxleft then nave.x := nave.x - nave.sx
  else if nave.dirx = dirxright then nave.x := nave.x + nave.sx;

  if nave.diry = diryup then nave.y := nave.y - nave.sy
  else if nave.diry = dirydown then nave.y := nave.y + nave.sy;

  if nave.x + LARGURA_NAVE >= LARGURA_TELA then nave.x := LARGURA_TELA - LARGURA_NAVE;
  if nave.x <= 0 then nave.x := 0;
  if nave.y <= 0 then nave.y := 0;
  if nave.y + ALTURA_NAVE >= ALTURA_TELA then nave.y := ALTURA_TELA - ALTURA_NAVE;
end;

procedure moverTirosNave();
var
	i : integer;
   c,s:real;
begin
	for i := 1 to MAX_TIROS_NAVE do
  	if tirosnave[i].Ativo = true then
    begin
    	case tirosnave[i].arma.tipo of
      	t1,t3,t4,t5:
         begin
         	tirosnave[i].Y:= tirosnave[i].Y - tirosnave[i].sy;
            tirosnave[i].x:= tirosnave[i].x + tirosnave[i].sx;
            if tirosnave[i].y < 0 then tirosnave[i].ativo := false;
         end;
         t2:
         begin
         	if tirosnave[i].lockonID = 0 then
            begin
            	tirosnave[i].y := tirosnave[i].y - tirosnave[i].speed;
               if tirosnave[i].y < -10 then tirosnave[i].ativo := false;
               if tirosnave[i].speed < 8 then tirosnave[i].speed := tirosnave[i].speed + tirosnave[i].accel;
            end
            else
            begin
            	if not inimigos[tirosnave[i].lockonID].ativo then
               begin
               	tirosnave[i].lockonID := procurarInimigoAtivo();
                  if tirosnave[i].lockonID = 0 then tirosnave[i].speed := 1;
               end
               else
               begin
               	c := _cos(inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura div 2, tirosnave[i].x, inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura div 2, tirosnave[i].y);
                  s := _sin(inimigos[tirosnave[i].lockonID].x + inimigos[tirosnave[i].lockonID].largura div 2, tirosnave[i].x, inimigos[tirosnave[i].lockonID].y + inimigos[tirosnave[i].lockonID].altura div 2, tirosnave[i].y);

                  if tirosnave[i].sx < c then tirosnave[i].sx := tirosnave[i].sx + 0.01
                  else if tirosnave[i].sx > c then tirosnave[i].sx := tirosnave[i].sx - 0.01;
                  if tirosnave[i].sy < s then tirosnave[i].sy := tirosnave[i].sy + 0.01
                  else if tirosnave[i].sy > s then tirosnave[i].sy := tirosnave[i].sy - 0.01;
               	tirosnave[i].x := tirosnave[i].x + tirosnave[i].speed * tirosnave[i].sx;
               	tirosnave[i].y := tirosnave[i].y + tirosnave[i].speed * tirosnave[i].sy;

                  if tirosnave[i].speed < 8 then tirosnave[i].speed := tirosnave[i].speed + tirosnave[i].accel;

               	if (tirosnave[i].x < -OFFSCREEN) or (tirosnave[i].x > LARGURA_TELA + OFFSCREEN) or (tirosnave[i].y > ALTURA_TELA + OFFSCREEN) or (tirosnave[i].y < -OFFSCREEN) then
               		tirosnave[i].ativo := false;
               end;
         	end;
         end;
      end;
  end;
end;

procedure TfGame.FormActivate(Sender: TObject);
var
	i: integer;
   oldcount : cardinal;
begin
	BackBuffer := TBitmap.Create;
	BackBuffer.Width := LARGURA_TELA;
   BackBuffer.Height := ALTURA_TELA;
   BackBuffer.Canvas.Brush.Color := clBlack;
   backbuffer.Canvas.Font.Color := clAqua;
   backbuffer.Canvas.Font.Name := 'courier new';
	backbuffer.canvas.font.size := 9;
  //Width := LARGURA_TELA;
  //Height := ALTURA_TELA + 24;
  canvas.Font.Color := clAqua;
  canvas.Brush.Style := bsclear;

  inicializarEstrelas();
  //inicializarPlanetas();

	NovoJogo();
	salvarDadosJogo();

   oldcount := gettickcount();

	while not Application.Terminated do
	begin
   	if gettickcount() - oldcount < 15 then
      begin
      	application.ProcessMessages;
         continue;
      end;

      oldcount := gettickcount();

   	lerTeclado(); // ler teclado antes do stage plan, porque se o jogo e carregado, a posicao sub fase sera 1, e 1 e utilizado dentro do stage plan, se o teclado fosse lido depois, a variavel posicaosubfase seria incrementada para 2, e nao seria possivel usar a posicao 1 dentro do stage plan!
   	if nave.armas[nave.weaponIndex].tempoCarregamento > 0 then dec(nave.armas[nave.weaponIndex].tempoCarregamento);
      if nave.tempoCarregamentoEspecial > 0 then dec(nave.tempoCarregamentoEspecial);
      
      // stage plan
   	case fase of
         1:
				case subfase of
            	1:
               	case PosicaoSubFase of
                 		1:
                     begin
                     	enviarmsg('Stage 1', clAqua, LARGURA_TELA div 2 - 40, ALTURA_TELA div 2 - 50, 0, 0, 100);
                     end;
                 		2..999:
                 		begin
                   		if PosicaoSubFase mod 50 = 1 then adicionarinimigo(Alien, random(LARGURA_TELA), -60, false);
                 		end;
               	end;
             2:
               case PosicaoSubFase of
                 1..999:
                 		if PosicaoSubFase mod 25 = 0 then adicionarinimigo(Viper, random(LARGURA_TELA), -20, false);
               end;
             3:
               case PosicaoSubFase of
                 1 :
                 begin
                   enviarmsg('Entering hyperspace...', clAqua, 0, 0, 0, 0, 200);
                   for i := 1 to MAX_ESTRELAS do stars[i].speed := 20 + random(15);
                   for i:= 1 to MAX_INIMIGOS do
                     if inimigos[i].ativo then inimigos[i].sy := inimigos[i].sy + 20;
                 end;
                 300: for i := 1 to MAX_ESTRELAS do stars[i].speed := 10 + random(8);
                 450: for i := 1 to MAX_ESTRELAS do stars[i].speed := 1 + random(5);
                 451: enviarmsg('Decelerating... enemy spaceship in front of us!', clAqua, 0, 0, 0, 0, 200);
                 550 : adicionaritem(LARGURA_TELA div 2 - 16, 100, autoTargetWeapon);
                 600:
                 begin
                   bosstime := true;
                   AdicionarInimigo(Boss1, (LARGURA_TELA div 2) - 132 + (LARGURA_TELA div 2) * sin(gamecounter / 90), -120, true); // precisa do seno pra ajustar a posicao de acordo com a funcao moverInimigos

                   enviarmsg('Report: Large enemy spaceship; Power: unkown', clAqua, 0, 0, 0, 0, 200);
                 end;
               end;
           	end;

      	2:
         	case subfase of
            	1:
               	case posicaosubfase of
                  	1: enviarmsg('Stage 2', clAqua, LARGURA_TELA div 2 - 40, ALTURA_TELA div 2 - 50, 0, 0, 100);
            			2..999: if PosicaoSubFase mod 20 = 0 then adicionarinimigo(Viper, random(LARGURA_TELA), -20, false);
            		end;
            end;
      end;
    // end of stage plan

      moverEstrelas();
      moverItems();
      atualizarAnimacoes();
      coletarItems();
      //moverPlanetas();

      MoverInimigos();
      MoverTirosInimigo();
      detectarDanosNaNave();

      movernave();
      movertirosNave();
      verificarDanosNoInimigo();

      detectarColisaoComInimigo();

      desenharJogo();

      Canvas.Draw(0, 0, BackBuffer);

      Inc(PosicaoSubFase);

      if PosicaoSubFase > 1024 then
      begin
        subfase := subfase + 1;
        PosicaoSubFase := 1;
      end;

      Inc(DrawCounter);
      inc(gamecounter);

      if tempoAcessoMenu > 0 then Dec(tempoAcessoMenu);

    Application.ProcessMessages;
 end;
end;

procedure TfGame.Timer3Timer(Sender: TObject);
begin
   fps := DrawCounter;
   drawcounter := 0;
end;

procedure TfGame.FormCreate(Sender: TObject);
begin
	oldheight := screen.Height;
   oldwidth := screen.Width;
	SetScreenResolution(800, 600, 16);
   ShowCursor(False);
end;

end.
