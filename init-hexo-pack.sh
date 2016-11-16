
############################################
#          更新 Next 主题插件
############################################

# 下载最新主题到指定路径:
git clone https://github.com/iissnan/hexo-theme-next themes/next


############################################
#         安装 hexo 和 相关插件
# 说明:
#   - 可被: npm i --no-optional 替代
############################################

# install hexo:
# sudo cnpm install -g hexo-cli
# sudo cnpm install hexo --save  --no-optional

# hexo-plugins:
# sudo cnpm install hexo-generator-index --save
# sudo cnpm install hexo-generator-archive --save
# sudo cnpm install hexo-generator-category --save
# sudo cnpm install hexo-generator-tag --save
# sudo cnpm install hexo-server --save
# sudo cnpm install hexo-deployer-git --save
# sudo cnpm install hexo-deployer-heroku --save
# sudo cnpm install hexo-deployer-rsync --save
# sudo cnpm install hexo-deployer-openshift --save
# sudo cnpm install hexo-renderer-marked@0.2 --save
# sudo cnpm install hexo-renderer-stylus@0.2 --save
# sudo cnpm install hexo-generator-feed@1 --save
# sudo cnpm install hexo-generator-sitemap@1 --save


############################################
#         重装 hexo 和 相关插件
# 说明:
#   - 依赖 package.json 文件
############################################

# 删除
# sudo rm -rf ./node_modules/

# 安装: 通过 package.json
npm i --no-optional


############################################
#                  发布
############################################

# 发布: 
# hexo d -g

############################################
#           博客资源 - 分支管理
############################################
# 本地创建 博客资源分支:
# git checkout -b blog_source

# 添加博客资源分支:
# git remote add blog_source git@github.com:hhstore/hhstore.github.io.git

# 推送:
# git push blog_source blog_source


