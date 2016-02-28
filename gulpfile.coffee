# モジュールの読み込み
gulp = require "gulp"
sass = require 'node-sass'
concat = require 'gulp-concat'
$ = do require "gulp-load-plugins"
browserSync = require "browser-sync"

# 同期を開始
gulp.task "bs", ->
  browserSync({
    server: {
      baseDir: "./" #HTMLのあるディレクトリを指定
    },
    browser: "safari"
  })

# リロード
gulp.task "bs-reload", ->
  browserSync.reload()

# Sassのコンパイル、AutoPrefixer、リロード
gulp.task "sass", ->
  $.rubySass([
    "./assets/stylesheets/*.sass",
    "./assets/stylesheets/**/*.sass",
    "./assets/stylesheets/**/**/*.sass"
    ], {style: "expanded"})
  .pipe $.autoprefixer()
  .pipe(concat('style.css'))
  .pipe gulp.dest "./stylesheets" #cssの出力先フォルダ
  .pipe browserSync.reload({stream:true})

# デフォルトのタスク(ファイルを監視)
gulp.task "default", ["sass", "bs"], ->
  gulp.watch "./*.html", ["bs-reload"]
  gulp.watch "./assets/stylesheets/*.sass", ["sass"]
  gulp.watch "./assets/stylesheets/**/*.sass", ["sass"]
  gulp.watch "./assets/stylesheets/**/**/*.sass", ["sass"]
