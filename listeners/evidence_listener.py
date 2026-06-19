import os
import glob
import base64
import datetime


class EvidenceListener:
    """Gera um arquivo HTML de evidência por teste executado."""

    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, output_dir="evidence"):
        self.output_dir = output_dir
        self._screenshot_dir = "."
        self._start_time = None
        self._current = {}
        self._snapshots_before = set()

    def start_suite(self, name, attrs):
        os.makedirs(self.output_dir, exist_ok=True)
        self._screenshot_dir = self._resolve_screenshot_dir()

    def start_test(self, name, attrs):
        self._start_time = datetime.datetime.now()
        self._current = {
            "name": name,
            "longname": attrs.get("longname", name),
            "tags": list(attrs.get("tags", [])),
        }
        self._snapshots_before = self._list_screenshots()

    def end_test(self, name, attrs):
        elapsed = (datetime.datetime.now() - self._start_time).total_seconds()
        new_shots = sorted(
            self._list_screenshots() - self._snapshots_before,
            key=os.path.getmtime,
        )
        html = self._render(
            status=attrs.get("status", "UNKNOWN"),
            message=attrs.get("message", ""),
            elapsed=elapsed,
            screenshots=new_shots,
        )
        parts = self._current["longname"].split(".")
        suite = parts[-2] if len(parts) >= 2 else parts[0]
        filename = f"{self._slug(suite)}__{self._slug(name)}.html"
        path = os.path.join(self.output_dir, filename)
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(html)

    # ── helpers ───────────────────────────────────────────────────────────────

    def _resolve_screenshot_dir(self):
        try:
            from robot.libraries.BuiltIn import BuiltIn
            d = BuiltIn().get_variable_value("${OUTPUT DIR}")
            if d and os.path.isdir(d):
                return d
        except Exception:
            pass
        return "."

    def _list_screenshots(self):
        pattern = os.path.join(self._screenshot_dir, "selenium-screenshot-*.png")
        return {os.path.abspath(p) for p in glob.glob(pattern)}

    def _slug(self, text):
        return "".join(c if c.isalnum() or c in "-_" else "_" for c in text)[:60]

    def _b64img(self, path):
        try:
            with open(path, "rb") as fh:
                return base64.b64encode(fh.read()).decode()
        except Exception:
            return ""

    def _render(self, status, message, elapsed, screenshots):
        color = "#198754" if status == "PASS" else "#dc3545"
        name = self._current["name"]
        longname = self._current["longname"]
        tags = self._current["tags"]
        start_str = self._start_time.strftime("%d/%m/%Y %H:%M:%S")
        now_str = datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S")

        tags_html = (
            "".join(f'<span class="tag">{t}</span>' for t in tags)
            or "<em style='color:#aaa'>sem tags</em>"
        )

        shots_html = ""
        for i, path in enumerate(screenshots, 1):
            data = self._b64img(path)
            if data:
                shots_html += (
                    f'<div class="shot">'
                    f'<p class="shot-label">Screenshot {i} — {os.path.basename(path)}</p>'
                    f'<img src="data:image/png;base64,{data}" alt="screenshot {i}">'
                    f"</div>"
                )
        if not shots_html:
            shots_html = '<p class="muted">Nenhum screenshot capturado neste teste.</p>'

        error_block = ""
        if status != "PASS" and message:
            error_block = (
                '<div class="card">'
                "<h2>Mensagem de Falha</h2>"
                f'<pre class="error-msg">{message}</pre>'
                "</div>"
            )

        return f"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Evidência — {name}</title>
  <style>
    *, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
    body {{ font-family: 'Segoe UI', system-ui, sans-serif; background: #f0f2f5; color: #212529; line-height: 1.5; }}

    .banner {{ background: {color}; color: #fff; padding: 28px 40px; }}
    .banner small {{ display: block; font-size: .8rem; opacity: .75; margin-bottom: 6px; }}
    .banner h1 {{ font-size: 1.4rem; font-weight: 600; }}
    .badge {{ display: inline-block; margin-top: 10px; background: rgba(255,255,255,.25);
               border-radius: 20px; padding: 3px 16px; font-size: .85rem; font-weight: 700; }}

    main {{ max-width: 980px; margin: 28px auto; padding: 0 16px;
             display: flex; flex-direction: column; gap: 18px; }}

    .card {{ background: #fff; border-radius: 10px; box-shadow: 0 1px 4px rgba(0,0,0,.08);
              padding: 24px 28px; }}
    h2 {{ font-size: .8rem; font-weight: 600; color: #6c757d; text-transform: uppercase;
           letter-spacing: .07em; margin-bottom: 16px; }}

    .meta-grid {{ display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }}
    .field label {{ display: block; font-size: .7rem; color: #adb5bd; text-transform: uppercase;
                     letter-spacing: .05em; margin-bottom: 3px; }}
    .field span {{ font-size: .95rem; }}

    .tag {{ background: #e7f1ff; color: #0d6efd; border-radius: 4px;
             padding: 2px 8px; font-size: .78rem; margin-right: 4px; }}

    .status-PASS {{ color: #198754; font-weight: 700; }}
    .status-FAIL {{ color: #dc3545; font-weight: 700; }}

    .error-msg {{ background: #fff5f5; border-left: 4px solid #dc3545; padding: 14px 18px;
                   border-radius: 4px; font-size: .85rem; white-space: pre-wrap;
                   word-break: break-word; }}

    .shot {{ margin-bottom: 24px; }}
    .shot-label {{ font-size: .78rem; color: #adb5bd; margin-bottom: 6px; }}
    .shot img {{ max-width: 100%; border: 1px solid #dee2e6; border-radius: 6px;
                  box-shadow: 0 2px 8px rgba(0,0,0,.06); }}

    .muted {{ color: #adb5bd; font-style: italic; }}
    footer {{ text-align: center; font-size: .75rem; color: #adb5bd; padding: 24px 0 32px; }}
  </style>
</head>
<body>
  <div class="banner">
    <small>{longname}</small>
    <h1>{name}</h1>
    <div class="badge">{status}</div>
  </div>

  <main>
    <div class="card">
      <h2>Metadados do Teste</h2>
      <div class="meta-grid">
        <div class="field"><label>Início</label><span>{start_str}</span></div>
        <div class="field"><label>Duração</label><span>{elapsed:.2f}s</span></div>
        <div class="field"><label>Tags</label><span>{tags_html}</span></div>
        <div class="field"><label>Status</label>
          <span class="status-{status}">{status}</span></div>
      </div>
    </div>

    {error_block}

    <div class="card">
      <h2>Screenshots</h2>
      {shots_html}
    </div>
  </main>

  <footer>Gerado em {now_str} · Robot Framework Evidence Listener</footer>
</body>
</html>"""
