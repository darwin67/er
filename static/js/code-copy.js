// Attach a copy-to-clipboard button to every <pre> inside post content.
(function () {
  function copyFallback(text, btn, status) {
    var ta = document.createElement('textarea');
    ta.value = text;
    ta.style.position = 'fixed';
    ta.style.opacity = '0';
    document.body.appendChild(ta);
    ta.select();
    var copied = false;
    try {
      copied = document.execCommand('copy');
    } catch (e) { /* ignore */ }
    document.body.removeChild(ta);
    showCopyStatus(btn, status, copied);
  }

  function copyText(text, btn, status) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).then(function () {
        showCopyStatus(btn, status, true);
      }).catch(function () {
        copyFallback(text, btn, status);
      });
      return;
    }
    copyFallback(text, btn, status);
  }

  function showCopyStatus(btn, status, copied) {
    var label = copied ? 'Copied' : 'Copy failed';
    var announcement = copied ? 'Code copied' : 'Copy failed';
    clearTimeout(btn.copyStatusTimer);
    btn.textContent = label;
    btn.setAttribute('aria-label', announcement);
    status.textContent = announcement;
    btn.copyStatusTimer = setTimeout(function () {
      btn.textContent = btn.getAttribute('data-label') || 'Copy';
      btn.setAttribute('aria-label', 'Copy code');
      status.textContent = '';
    }, 1500);
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
    var status = document.createElement('span');
    status.className = 'sr-only';
    status.setAttribute('role', 'status');
    status.setAttribute('aria-live', 'polite');
    btn.addEventListener('click', function () {
      var text = (code ? code.innerText : pre.innerText) || '';
      copyText(text, btn, status);
    });
    wrap.appendChild(btn);
    wrap.appendChild(status);
  }

  document.addEventListener('DOMContentLoaded', function () {
    var nodes = document.querySelectorAll('.post-content pre');
    nodes.forEach(function (pre) {
      if (!pre.closest('.mermaid, .src-mermaid')) enhance(pre);
    });
  });
})();
