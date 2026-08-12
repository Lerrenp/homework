/* ============================================================
 * mjl · 物联网作品集 - 主脚本
 *
 * 功能模块：
 *   1. 主题切换（浅色 / 深色 / 跟随系统）
 *   2. 从 GitHub API 动态拉取 Lerrenp 的仓库作为作品集
 *   3. Canvas 鸟群（Boids）动画：
 *      - 跟随鼠标（吸引/排斥）
 *      - 与窗口边界交互（绕飞/反弹）
 *      - 切换主题时颜色实时跟随
 * ============================================================ */

(function () {
  'use strict';

  /* ----------------------------------------------------------
   * GitHub 用户配置
   * -------------------------------------------------------- */
  const GH_USER = 'Lerrenp';
  const GH_API_REPOS = `https://api.github.com/users/${GH_USER}/repos?per_page=100&sort=updated`;

  // 语言颜色（与 GitHub 配色保持一致）
  const LANG_COLORS = {
    JavaScript: '#f1e05a',
    TypeScript: '#3178c6',
    Python: '#3572A5',
    HTML: '#e34c26',
    CSS: '#563d7c',
    'C++': '#f34b7d',
    C: '#555555',
    Java: '#b07219',
    Go: '#00ADD8',
    Rust: '#dea584',
    Shell: '#89e051',
    Vue: '#41b883',
    Svelte: '#ff3e00',
  };

  /* ----------------------------------------------------------
   * 1. 主题切换
   * -------------------------------------------------------- */
  const THEME_KEY = 'mjl-portfolio-theme';
  const root = document.documentElement;

  function getStoredTheme() {
    try {
      return localStorage.getItem(THEME_KEY);
    } catch (_) {
      return null;
    }
  }

  function applyTheme(theme) {
    // theme: 'light' | 'dark' | 'system'
    if (theme === 'system') {
      root.removeAttribute('data-theme');
    } else {
      root.setAttribute('data-theme', theme);
    }
    updateThemeButton();
    // 触发鸟群颜色更新
    window.dispatchEvent(new CustomEvent('themechange', { detail: { theme } }));
  }

  function updateThemeButton() {
    const btn = document.getElementById('theme-toggle');
    if (!btn) return;
    const stored = getStoredTheme() || 'system';
    const effective = stored === 'system'
      ? (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
      : stored;
    btn.setAttribute('aria-label',
      effective === 'dark' ? '切换到浅色模式' : '切换到深色模式');
    btn.setAttribute('data-mode', stored);
    btn.innerHTML = effective === 'dark' ? ICON_SUN : ICON_MOON;
  }

  function cycleTheme() {
    const current = getStoredTheme() || 'system';
    const next = current === 'light' ? 'dark' : current === 'dark' ? 'system' : 'light';
    try {
      localStorage.setItem(THEME_KEY, next);
    } catch (_) {}
    applyTheme(next);
  }

  function initTheme() {
    applyTheme(getStoredTheme() || 'system');
    const btn = document.getElementById('theme-toggle');
    if (btn) btn.addEventListener('click', cycleTheme);

    // 系统主题变化时，若当前为 system 模式则响应
    const mql = window.matchMedia('(prefers-color-scheme: dark)');
    mql.addEventListener('change', () => {
      if ((getStoredTheme() || 'system') === 'system') {
        applyTheme('system');
      }
    });
  }

  /* SVG 图标 */
  const ICON_MOON =
    '<svg viewBox="0 0 24 24"><path d="M12 3a9 9 0 1 0 9 9c0-.46-.04-.92-.1-1.36a5.39 5.39 0 0 1-4.4 2.26 5.4 5.4 0 0 1-3.14-9.8c-.44-.06-.9-.1-1.36-.1z"/></svg>';
  const ICON_SUN =
    '<svg viewBox="0 0 24 24"><path d="M12 7a5 5 0 1 0 0 10 5 5 0 0 0 0-10zm0-5v2m0 16v2M4.93 4.93l1.41 1.41m11.32 11.32 1.41 1.41M2 12h2m16 0h2M4.93 19.07l1.41-1.41M17.66 6.34l1.41-1.41"/></svg>';
  const ICON_STAR =
    '<svg viewBox="0 0 24 24"><path d="M12 17.27 18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>';

  /* ----------------------------------------------------------
   * 2. 拉取 GitHub 仓库列表
   * -------------------------------------------------------- */
  async function loadRepos() {
    const status = document.getElementById('repo-status');
    const grid = document.getElementById('project-grid');
    if (!grid) return;

    // 显示 3 个骨架占位
    grid.innerHTML = Array.from({ length: 3 }, () => `
      <div class="project-card">
        <span class="skeleton" style="width: 40%;"></span>
        <span class="skeleton" style="width: 80%; height: 22px;"></span>
        <span class="skeleton" style="width: 100%;"></span>
        <span class="skeleton" style="width: 60%;"></span>
      </div>
    `).join('');

    try {
      const res = await fetch(GH_API_REPOS, {
        headers: { Accept: 'application/vnd.github+json' },
      });
      if (!res.ok) throw new Error(`HTTP ${res.status}`);
      const repos = await res.json();

      // 过滤：排除 fork 仓库，按更新时间倒序
      const filtered = repos
        .filter((r) => !r.fork)
        .sort((a, b) => new Date(b.updated_at) - new Date(a.updated_at));

      renderRepos(filtered);
      if (status) {
        status.classList.remove('error');
        status.innerHTML = `<span class="dot"></span> 来自 GitHub @${GH_USER} · 共 ${filtered.length} 个项目`;
      }
    } catch (err) {
      console.warn('[portfolio] 仓库加载失败:', err);
      grid.innerHTML = '';
      if (status) {
        status.classList.add('error');
        status.innerHTML = `<span class="dot"></span> GitHub 数据加载失败（${err.message}），请检查网络或稍后重试`;
      }
    }
  }

  function escapeHtml(str) {
    return String(str || '').replace(/[&<>"']/g, (c) => ({
      '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
    }[c]));
  }

  function renderRepos(repos) {
    const grid = document.getElementById('project-grid');
    if (!grid) return;

    if (!repos.length) {
      grid.innerHTML = `<div class="project-card"><p>暂无公开的非 fork 仓库。</p></div>`;
      return;
    }

    grid.innerHTML = repos
      .map((repo) => {
        const lang = repo.language || '—';
        const langColor = LANG_COLORS[lang] || '#94a3b8';
        const desc = repo.description
          ? escapeHtml(repo.description)
          : '暂无描述';
        const tag = deriveTag(repo);
        const stars = repo.stargazers_count || 0;

        return `
        <a class="project-card" href="${repo.html_url}" target="_blank" rel="noopener noreferrer">
          <span class="project-tag">${escapeHtml(tag)}</span>
          <h3>${escapeHtml(repo.name)} <span class="ext-icon">${ICON_STAR}</span></h3>
          <p>${desc}</p>
          <div class="meta">
            <span class="lang">
              <span class="lang-dot" style="--lang-color:${langColor};background:${langColor}"></span>
              ${escapeHtml(lang)}
            </span>
            <span class="stars">${ICON_STAR} ${stars}</span>
          </div>
        </a>`;
      })
      .join('');
  }

  /** 从仓库描述或名称启发式生成 tag */
  function deriveTag(repo) {
    const text = `${repo.name} ${repo.description || ''}`.toLowerCase();
    if (/(iot|物联网|sensor|esp|stm|zigbee|lora|ble|embedded)/.test(text)) return '物联网';
    if (/(bilibili|bili|video|player)/.test(text)) return '视频播放';
    if (/(kernel|android|root|suki)/.test(text)) return '内核编译';
    if (/(openai|gemini|api|llm)/.test(text)) return 'AI / API';
    if (/(defocus|eye|护眼)/.test(text)) return '健康工具';
    if (/(homework|note|learn|学习|笔记)/.test(text)) return '学习笔记';
    if (repo.language) return repo.language;
    return 'Project';
  }

  /* ----------------------------------------------------------
   * 3. Canvas 鸟群动画（Boids 简化版 + 鼠标交互）
   * -------------------------------------------------------- */
  class Flock {
    constructor(canvas) {
      this.canvas = canvas;
      this.ctx = canvas.getContext('2d');
      this.dpr = Math.min(window.devicePixelRatio || 1, 2);
      this.birds = [];
      this.mouse = { x: -1000, y: -1000, active: false };
      this.color = '#00658f';
      this.wingColor = '#001e2e';

      this.resize();
      window.addEventListener('resize', () => this.resize());
      window.addEventListener('mousemove', (e) => {
        this.mouse.x = e.clientX;
        this.mouse.y = e.clientY;
        this.mouse.active = true;
      });
      window.addEventListener('mouseleave', () => {
        this.mouse.active = false;
      });
      // 主题变化时取色
      window.addEventListener('themechange', () => this.updateColors());

      this.updateColors();
      this.spawn();
      this.tick = this.tick.bind(this);
      requestAnimationFrame(this.tick);
    }

    resize() {
      const w = window.innerWidth;
      const h = window.innerHeight;
      this.canvas.width = w * this.dpr;
      this.canvas.height = h * this.dpr;
      this.canvas.style.width = w + 'px';
      this.canvas.style.height = h + 'px';
      this.ctx.setTransform(this.dpr, 0, 0, this.dpr, 0, 0);
      this.width = w;
      this.height = h;
      // 数量根据屏幕面积自适应
      const target = Math.max(28, Math.min(80, Math.round((w * h) / 22000)));
      this.resizeFlock(target);
    }

    resizeFlock(target) {
      while (this.birds.length < target) this.birds.push(this.makeBird());
      while (this.birds.length > target) this.birds.pop();
    }

    updateColors() {
      const styles = getComputedStyle(document.documentElement);
      this.color = styles.getPropertyValue('--bird-color').trim() || '#00658f';
      this.wingColor = styles.getPropertyValue('--bird-wing').trim() || '#001e2e';
    }

    spawn() {
      const w = this.width, h = this.height;
      const initial = Math.max(28, Math.min(80, Math.round((w * h) / 22000)));
      for (let i = 0; i < initial; i++) this.birds.push(this.makeBird());
    }

    makeBird() {
      const w = this.width, h = this.height;
      const speed = 1.2 + Math.random() * 1.6;
      const angle = Math.random() * Math.PI * 2;
      return {
        x: Math.random() * w,
        y: Math.random() * h,
        vx: Math.cos(angle) * speed,
        vy: Math.sin(angle) * speed,
        size: 6 + Math.random() * 4,
        flapPhase: Math.random() * Math.PI * 2,
        flapSpeed: 0.18 + Math.random() * 0.1,
        maxSpeed: 2.6 + Math.random() * 1.2,
      };
    }

    tick() {
      const ctx = this.ctx;
      ctx.clearRect(0, 0, this.width, this.height);
      for (const b of this.birds) this.update(b);
      this.drawAll(ctx);
      requestAnimationFrame(this.tick);
    }

    update(b) {
      const w = this.width, h = this.height;

      // 邻居聚合与对齐（半径内）
      let alignX = 0, alignY = 0, cohX = 0, cohY = 0, sepX = 0, sepY = 0;
      let count = 0;
      const perception = 80;

      for (const o of this.birds) {
        if (o === b) continue;
        const dx = o.x - b.x, dy = o.y - b.y;
        const dist = Math.hypot(dx, dy);
        if (dist < perception && dist > 0) {
          alignX += o.vx; alignY += o.vy;
          cohX += o.x; cohY += o.y;
          if (dist < 22) {
            // 分离：距离越近排斥越强
            const push = (22 - dist) / 22;
            sepX -= (dx / dist) * push * 1.4;
            sepY -= (dy / dist) * push * 1.4;
          }
          count++;
        }
      }

      if (count > 0) {
        alignX /= count; alignY /= count;
        cohX = cohX / count - b.x;
        cohY = cohY / count - b.y;
        b.vx += alignX * 0.02 + cohX * 0.005 + sepX;
        b.vy += alignY * 0.02 + cohY * 0.005 + sepY;
      }

      // 鼠标交互：吸引 + 适度排斥
      if (this.mouse.active) {
        const mdx = this.mouse.x - b.x;
        const mdy = this.mouse.y - b.y;
        const md = Math.hypot(mdx, mdy);
        if (md < 220 && md > 0) {
          const attract = 0.08;
          b.vx += (mdx / md) * attract;
          b.vy += (mdy / md) * attract;
          if (md < 70) {
            // 太近时排斥，避免贴脸
            const push = (70 - md) / 70;
            b.vx -= (mdx / md) * push * 0.9;
            b.vy -= (mdy / md) * push * 0.9;
          }
        }
      }

      // 窗口边界：靠近时反向轻推
      const margin = 60;
      if (b.x < margin) b.vx += (margin - b.x) / margin * 0.4;
      if (b.x > w - margin) b.vx -= (b.x - (w - margin)) / margin * 0.4;
      if (b.y < margin) b.vy += (margin - b.y) / margin * 0.4;
      if (b.y > h - margin) b.vy -= (b.y - (h - margin)) / margin * 0.4;

      // 限制速度
      const sp = Math.hypot(b.vx, b.vy);
      if (sp > b.maxSpeed) {
        b.vx = (b.vx / sp) * b.maxSpeed;
        b.vy = (b.vy / sp) * b.maxSpeed;
      } else if (sp < 0.6) {
        // 防止停滞
        b.vx += (Math.random() - 0.5) * 0.4;
        b.vy += (Math.random() - 0.5) * 0.4;
      }

      b.x += b.vx;
      b.y += b.vy;

      // 出界兜底（理论上边界处理已防止，但极端情况保留）
      if (b.x < -20) b.x = w + 20;
      if (b.x > w + 20) b.x = -20;
      if (b.y < -20) b.y = h + 20;
      if (b.y > h + 20) b.y = -20;

      // 翅膀拍打
      b.flapPhase += b.flapSpeed;
    }

    drawAll(ctx) {
      for (const b of this.birds) {
        const angle = Math.atan2(b.vy, b.vx);
        const flap = Math.sin(b.flapPhase) * 0.55;
        const size = b.size;
        ctx.save();
        ctx.translate(b.x, b.y);
        ctx.rotate(angle);

        // 身体（流线型）
        ctx.fillStyle = this.color;
        ctx.beginPath();
        ctx.moveTo(size * 1.4, 0);
        ctx.quadraticCurveTo(size * 0.6, -size * 0.45, -size * 1.1, 0);
        ctx.quadraticCurveTo(size * 0.6, size * 0.45, size * 1.4, 0);
        ctx.fill();

        // 双翼（拍打幅度）
        ctx.fillStyle = this.wingColor;
        ctx.globalAlpha = 0.85;
        // 上翼
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.quadraticCurveTo(-size * 0.3, -size * (0.9 + flap), -size * 1.1, -size * 0.1);
        ctx.quadraticCurveTo(-size * 0.5, -size * 0.05, 0, 0);
        ctx.fill();
        // 下翼
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.quadraticCurveTo(-size * 0.3, size * (0.9 - flap), -size * 1.1, size * 0.1);
        ctx.quadraticCurveTo(-size * 0.5, size * 0.05, 0, 0);
        ctx.fill();

        ctx.restore();
      }
    }
  }

  function initFlock() {
    const canvas = document.getElementById('flock-canvas');
    if (!canvas) return;
    try {
      const flock = new Flock(canvas);
      // 在 HUD 上显示鸟群数量
      const hud = document.getElementById('bird-count');
      if (hud) hud.textContent = String(flock.birds.length);
    } catch (err) {
      console.warn('[portfolio] 鸟群动画初始化失败:', err);
    }
  }

  /* ----------------------------------------------------------
   * 启动
   * -------------------------------------------------------- */
  document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initFlock();
    loadRepos();
  });
})();