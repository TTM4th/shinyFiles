# shinyFiles
環境読み込み時に日本語のボリュームラベルを読み込んだ際に発生する、マルチバイト文字列非対応によるエラーを回避するよう修正
従来ではaaa.R getVolumes関数内の
"volNames <- system(paste(wmic, "/FAILFAST:1000 logicaldisk get VolumeName"), intern = TRUE, ignore.stderr=TRUE)"
にて取得した値がshift-jisのためエンコード違いによる文字化けが原因で処理が中断されるが、iconv関数でutf-8にエンコードを変更することで正常な値の取得が可能になる。
