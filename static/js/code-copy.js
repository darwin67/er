// Attach a copy-to-clipboard button to every <pre> inside post content.
(function () {
  function copyText(text, btn) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      return navigator.clipboard.writeText(text).then(function () {
        showCopied(btn);
      });
    }
    var ta = document.createElement('textarea');
    ta.value = text;
    ta.style.position = 'fixed';
    ta.style.opacity = '0';
    document.body.appendChild(ta);
    ta.select();
    try { document.execCommand('copy'); showCopied(btn); } catch (e) { /* ignore */ }
    document.body.removeChild(ta);
  }

  function showCopied(btn) {
    var prev = btn.getAttribute('data-label') || 'Copy';
    btn.textContent = 'Copied';
    setTimeout(function () { btn.textContent = prev; }, 1500);
  }

  function enhance(pre) {
    if (pre.dataset.codeCopyReady === '1') return;
    pre.dataset.codeCopyReady = '1';

    var wrap = document.createElement('div');
    wrap.className = 'code-block';
    pre.parentNode.insertBefore(wrap, pre);
    wrap.appendChild(pre);

    var lang = '';
    var code = pre.querySelector('code');
    if (code) {
      var match = (code.className || '').match(/language-([\w-]+)/);
      if (match) lang = match[1];
    }
    if (lang) {
      var label = document.createElement('span');
      label.className = 'code-block-lang';
      label.textContent = lang;
      wrap.appendChild(label);
    }

    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'code-block-copy';
    btn.setAttribute('aria-label', 'Copy code');
    btn.setAttribute('data-label', 'Copy');
    btn.textContent = 'Copy';
    btn.addEventListener('click', function () {
      var text = (code ? code.innerText : pre.innerText) || '';
      copyText(text, btn);
    });
    wrap.appendChild(btn);
  }

  document.addEventListener('DOMContentLoaded', function () {
    var nodes = document.querySelectorAll('.post-content pre');
    nodes.forEach(enhance);
  });
})();
