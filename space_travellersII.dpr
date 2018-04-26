program space_travellersII;

uses
  Forms,
  main in '..\Space Travellers II\main.pas' {fGame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Space Travellers II';
  Application.CreateForm(TfGame, fGame);
  Application.Run;
end.
