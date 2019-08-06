unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, MyAccess, MemDS;

type
  Tdm = class(TDataModule)
    quDiagnosa: TMyQuery;
    con: TMyConnection;
    dsDiagnosa: TMyDataSource;
    quHasil: TMyQuery;
    dsHasil: TMyDataSource;
    quDiagnosakdPenyakit: TStringField;
    quDiagnosabobot: TFloatField;
    quDiagnosakdGejala: TIntegerField;
    quDiagnosabobotRule: TFloatField;
    quHasilkdPenyakit: TStringField;
    quHasilperkalian: TFloatField;
    quHasilhasil: TFloatField;
    quPenyakit: TMyQuery;
    dsPenyakit: TMyDataSource;
    quGejala: TMyQuery;
    dsGejala: TMyDataSource;
    dsRule: TMyDataSource;
    quRule: TMyQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
