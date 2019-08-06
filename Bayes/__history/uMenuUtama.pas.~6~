unit uMenuUtama;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TfoUtama = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Image5Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    procedure dataPenyakit;
    { Private declarations }
  public
    { Public declarations }
    procedure diagnosa;
    procedure penyakit;
    procedure gejala;
    procedure rule;
  end;

var
  foUtama: TfoUtama;

implementation

{$R *.dfm}

uses uDiagnosa, uPenyakit, uGejala, uRule;

procedure TfoUtama.dataPenyakit;
begin

end;

procedure TfoUtama.diagnosa;
begin
  foDiagnosa := TfoDiagnosa.Create(Self);
  try
    foDiagnosa.Position:=poMainFormCenter;
    foDiagnosa.ShowModal;
  finally
    foDiagnosa.Free;
  end;
end;

procedure TfoUtama.gejala;
begin
  foGejala := TfoGejala.Create(Self);
  try
    foGejala.Position:=poMainFormCenter;
    foGejala.ShowModal;
  finally
    foGejala.Free;
  end;
end;

procedure TfoUtama.Image2Click(Sender: TObject);
begin
  penyakit;
end;

procedure TfoUtama.Image3Click(Sender: TObject);
begin
  gejala;
end;

procedure TfoUtama.Image4Click(Sender: TObject);
begin
  rule;
end;

procedure TfoUtama.Image5Click(Sender: TObject);
begin
  diagnosa;
end;

procedure TfoUtama.Label1Click(Sender: TObject);
begin
  penyakit;
end;

procedure TfoUtama.Label2Click(Sender: TObject);
begin
  gejala;
end;

procedure TfoUtama.Label3Click(Sender: TObject);
begin
   rule;
end;

procedure TfoUtama.Label4Click(Sender: TObject);
begin
  diagnosa;
end;

procedure TfoUtama.penyakit;
begin
  foPenyakit := TfoPenyakit.Create(Self);
  try
    foPenyakit.Position:=poMainFormCenter;
    foPenyakit.ShowModal;
  finally
    foPenyakit.Free;
  end;
end;

procedure TfoUtama.rule;
begin
  foRule := TfoRule.Create(Self);
  try
    foRule.Position:=poMainFormCenter;
    foRule.ShowModal;
  finally
    foRule.Free;
  end;
end;

end.
