unit uDiagnosa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh;

type
  TfoDiagnosa = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    DBGridEh1: TDBGridEh;
    GroupBox2: TGroupBox;
    lHasil: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure gridbersih;
    PROCEDURE CEKBOX1;
    PROCEDURE CEKBOX2;
    PROCEDURE CEKBOX3;
    procedure cekbox4;
    procedure cekbox5;
    procedure cekbox6;
    procedure cekbox7;
    procedure kali;
  end;

var
  foDiagnosa: TfoDiagnosa;

implementation

{$R *.dfm}

uses uDM;

procedure TfoDiagnosa.Button1Click(Sender: TObject);
var
  hasil : string;
begin
  gridbersih;
  //Procedure Input Hasil CheckBox1 yang bernilai TRUE 
  CEKBOX1;
  //Procedure Input Hasil CheckBox2 yang bernilai TRUE
  CEKBOX2
  //Procedure Input Hasil CheckBox3 yang bernilai TRUE
  CEKBOX3;
  //Procedure Input Hasil CheckBox4 yang bernilai TRUE
  cekbox4;
  //Procedure Input Hasil CheckBox5 yang bernilai TRUE
  cekbox5;
  //Procedure Input Hasil CheckBox6 yang bernilai TRUE
  cekbox6;
  //Procedure Input Hasil CheckBox7 yang bernilai TRUE
  cekbox7;
  //Procedure input ke tabel tbHasil diagnosa untuk dihitung perkaliannya
  kali;

  //Proses Perhitungan rumus Bayes dalam menentukan Hasil Diagnosa
  with dm.quhasil do
  begin
    Close;
    sql.Clear;
    sql.Text := 'UPDATE tbHasil set '+
      'perkalian= '+
      'case '+
        'when kdPenyakit="A" then (SELECT (EXP(SUM(LOG(bobotRule))) * 0.5) FROM tbdiagnosa where kdPenyakit="A") '+
        'when kdPenyakit="B" then (SELECT (EXP(SUM(LOG(bobotRule))) * 0.6) FROM tbdiagnosa where kdPenyakit="B") '+
        'when kdPenyakit="D" then (SELECT (EXP(SUM(LOG(bobotRule))) * 0.6) FROM tbdiagnosa where kdPenyakit="D") '+
        'when kdPenyakit="F" then (SELECT (EXP(SUM(LOG(bobotRule))) * 0.7) FROM tbdiagnosa where kdPenyakit="F") '+
      'end; '+
      'set @jumlah := (SELECT SUM(perkalian) from tbHasil); '+
      'update tbHasil set hasil = '+
      'case '+
        'when kdPenyakit="A" THEN perkalian/@jumlah '+
        'when kdPenyakit="B" THEN perkalian/@jumlah '+
        'when kdPenyakit="D" THEN perkalian/@jumlah '+
        'when kdPenyakit="F" THEN perkalian/@jumlah '+
      'end;';
    ExecSQL;
  end;
  dm.quHasil.SQL.Text := 'select * from tbHasil';
  dm.quHasil.Open;
  dm.quHasil.ExecSQL;

  //Proses Sorting Hasil Diagnosa berdasarkan dari nilai yang terbesar
  with dm.quHasil do
  begin
    Close;
    SQL.Clear;
    sql.Text:='select * from tbHasil ORDER BY hasil desc';
    ExecSQL;
  end;

  //Proses menampilkan Hasil akhir Diagnosa dari nilai Hasil yang terbesar
  with dm.quPenyakit do
  begin
    close;
    sql.Clear;
    sql.Text:='select tbpenyakit.nmPenyakit, tbHasil.hasil '+
              'from tbpenyakit JOIN tbHasil '+
              'WHERE tbHasil.kdPenyakit=tbpenyakit.kdPenyakit '+
              'ORDER BY tbHasil.hasil desc;';
    ExecSQL;
  end;
  hasil:=dm.quPenyakit.Fields[0].Text;
  lHasil.Caption:='Dari Hasil Diagnosa, Anda Terkena Penyakit "'+hasil+'"';

end;

procedure TfoDiagnosa.CEKBOX1;
begin
  if CheckBox1.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='1';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='1';
      ParamByName('bobotRule').AsString:='0.7';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='1';
      ParamByName('bobotRule').AsString:='0.7';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='1';
      ParamByName('bobotRule').AsString:='0.6';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.CEKBOX2;
begin
  if CheckBox2.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='2';
      ParamByName('bobotRule').AsString:='0.9';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='2';
      ParamByName('bobotRule').AsString:='0.1';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='2';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='2';
      ParamByName('bobotRule').AsString:='0.5';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.CEKBOX3;
begin
  if CheckBox3.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='3';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='3';
      ParamByName('bobotRule').AsString:='0.7';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='3';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='3';
      ParamByName('bobotRule').AsString:='0.75';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.cekbox4;
begin
  if CheckBox4.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='4';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='4';
      ParamByName('bobotRule').AsString:='0.9';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='4';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='4';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.cekbox5;
begin
  if CheckBox5.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='5';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='5';
      ParamByName('bobotRule').AsString:='0.3';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='5';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='5';
      ParamByName('bobotRule').AsString:='0.9';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.cekbox6;
begin
  if CheckBox6.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='6';
      ParamByName('bobotRule').AsString:='0.95';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='6';
      ParamByName('bobotRule').AsString:='0.3';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='6';
      ParamByName('bobotRule').AsString:='0.7';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='6';
      ParamByName('bobotRule').AsString:='0.3';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.cekbox7;
begin
  if CheckBox7.Checked=True then
  begin
    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='A';
      ParamByName('bobot').AsString:='0.5';
      ParamByName('kdGejala').AsString:='7';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='B';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='7';
      ParamByName('bobotRule').AsString:='0.2';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='D';
      ParamByName('bobot').AsString:='0.6';
      ParamByName('kdGejala').AsString:='7';
      ParamByName('bobotRule').AsString:='0.9';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;

    with dm.quDiagnosa do
    begin
      Close;
      sql.Clear;
      sql.Text := 'insert into tbdiagnosa (kdPenyakit, bobot, kdGejala, bobotRule) VALUE '+
                '(:kdPenyakit, :bobot, :kdGejala, :bobotRule);';
      ParamByName('kdPenyakit').AsString:='F';
      ParamByName('bobot').AsString:='0.7';
      ParamByName('kdGejala').AsString:='7';
      ParamByName('bobotRule').AsString:='0.5';
      ExecSQL;
      SQL.Text := 'select * from tbdiagnosa';
      Open;
    end;
  end;
end;

procedure TfoDiagnosa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gridbersih;
end;

procedure TfoDiagnosa.gridbersih;
begin
  dm.quDiagnosa.Close;
  dm.quDiagnosa.SQL.clear;
  dm.quDiagnosa.SQL.TEXT:='delete from tbDiagnosa';
  dm.quDiagnosa.ExecSQL;

  dm.quHasil.Close;
  dm.quHasil.SQL.clear;
  dm.quHasil.SQL.TEXT:='delete from tbHasil';
  dm.quHasil.ExecSQL;
end;

procedure TfoDiagnosa.kali;
begin
  with dm.quHasil do
  begin
    SQL.Text:='insert into tbHasil (kdPenyakit) value (:kdPenyakit)';
    ParamByName('kdPenyakit').AsString:='A';
    ExecSQL;
    SQL.Text:='select * from tbHasil';
    Open;
  end;

  with dm.quHasil do
  begin
    SQL.Text:='insert into tbHasil (kdPenyakit) value (:kdPenyakit)';
    ParamByName('kdPenyakit').AsString:='B';
    ExecSQL;
    SQL.Text:='select * from tbHasil';
    Open;
  end;

  with dm.quHasil do
  begin
    SQL.Text:='insert into tbHasil (kdPenyakit) value (:kdPenyakit)';
    ParamByName('kdPenyakit').AsString:='D';
    ExecSQL;
    SQL.Text:='select * from tbHasil';
    Open;
  end;

  with dm.quHasil do
  begin
    SQL.Text:='insert into tbHasil (kdPenyakit) value (:kdPenyakit)';
    ParamByName('kdPenyakit').AsString:='F';
    ExecSQL;
    SQL.Text:='select * from tbHasil';
    Open;
  end;
end;

end.