# モジュールの読み込み
gulp = require "gulp"
sass = require 'gulp-ruby-sass'
$ = do require "gulp-load-plugins"
browserSync = require "browser-sync"

# 同期を開始
gulp.task "bs", ->
  browserSync({
    server: {
      baseDir: "./" #HTMLのあるディレクトリを指定
    }
  })

# リロード
gulp.task "bs-reload", ->
  browserSync.reload()

# Sassのコンパイル、AutoPrefixer、リロード
gulp.task "sass", ->
  $.rubySass("./", {style: "compressed"})
  .pipe $.autoprefixer()
  .pipe gulp.dest "./" #cssの出力先フォルダ
  .pipe browserSync.reload({stream:true})

# デフォルトのタスク(ファイルを監視)
gulp.task "default", ["sass", "bs"], ->
  gulp.watch "./*.html", ["bs-reload"]
  gulp.watch "./*.scss", ["sass"]
