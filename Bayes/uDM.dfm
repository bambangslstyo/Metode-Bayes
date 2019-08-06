object dm: Tdm
  OldCreateOrder = False
  Height = 317
  Width = 472
  object quDiagnosa: TMyQuery
    Connection = con
    SQL.Strings = (
      'select *from tbDiagnosa')
    Active = True
    Left = 72
    Top = 16
    object quDiagnosakdPenyakit: TStringField
      FieldName = 'kdPenyakit'
      Origin = 'tbdiagnosa.kdPenyakit'
      Size = 5
    end
    object quDiagnosabobot: TFloatField
      FieldName = 'bobot'
      Origin = 'tbdiagnosa.bobot'
    end
    object quDiagnosakdGejala: TIntegerField
      FieldName = 'kdGejala'
      Origin = 'tbdiagnosa.kdGejala'
    end
    object quDiagnosabobotRule: TFloatField
      FieldName = 'bobotRule'
      Origin = 'tbdiagnosa.bobotRule'
    end
  end
  object con: TMyConnection
    Database = 'dbbayes'
    Username = 'root'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object dsDiagnosa: TMyDataSource
    DataSet = quDiagnosa
    Left = 72
    Top = 72
  end
  object quHasil: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from tbhasil')
    Active = True
    Left = 152
    Top = 16
    object quHasilkdPenyakit: TStringField
      DisplayLabel = 'Kode Penyakit'
      DisplayWidth = 12
      FieldName = 'kdPenyakit'
      Origin = 'tbhasil.kdPenyakit'
      Size = 5
    end
    object quHasilperkalian: TFloatField
      DisplayWidth = 10
      FieldName = 'perkalian'
      Origin = 'tbhasil.perkalian'
      Visible = False
    end
    object quHasilhasil: TFloatField
      DisplayLabel = 'Hasil Diagnosa'
      DisplayWidth = 15
      FieldName = 'hasil'
      Origin = 'tbhasil.hasil'
    end
  end
  object dsHasil: TMyDataSource
    DataSet = quHasil
    Left = 152
    Top = 72
  end
  object quPenyakit: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from tbPenyakit')
    Active = True
    Left = 232
    Top = 16
  end
  object dsPenyakit: TMyDataSource
    DataSet = quPenyakit
    Left = 232
    Top = 72
  end
  object quGejala: TMyQuery
    Connection = con
    SQL.Strings = (
      'select * from tbGejala')
    Active = True
    Left = 312
    Top = 16
  end
  object dsGejala: TMyDataSource
    DataSet = quGejala
    Left = 312
    Top = 72
  end
  object dsRule: TMyDataSource
    DataSet = quRule
    Left = 72
    Top = 200
  end
  object quRule: TMyQuery
    Connection = con
    SQL.Strings = (
      
        'select tbrule.kdPenyakit, tbpenyakit.nmPenyakit, tbpenyakit.bobo' +
        't,'
      'tbrule.kdGejala, tbgejala.nmGejala,'#9'tbrule.bobotRule'
      'from tbrule, tbpenyakit, tbgejala'
      'WHERE tbrule.kdPenyakit=tbpenyakit.kdPenyakit'
      'and tbrule.kdGejala=tbgejala.kdGejala')
    Active = True
    Left = 72
    Top = 144
  end
end
