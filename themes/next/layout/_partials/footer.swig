<!--script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script-->
<!--span id="busuanzi_container_site_pv">本站总访问量<span id="busuanzi_value_site_pv"></span>次</span-->
<div class="copyright">
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">
  {{ current }}
  </span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
  <div>
  粤ICP备 -
  <a href="http://www.beian.miit.gov.cn">18045940号-2</a>
  </a>
</div>
</div>