# Nivela1 — Landing page (demo)

Demo estática de la landing pública de **Academia NivelA1**, desplegada en Vercel.

> Esta rama contiene **únicamente la landing de marketing**. El sistema completo
> (JSP/Servlets + PostgreSQL: intranet, panel admin, docente y estudiante) vive en
> las ramas `master` / `ramahebert` y no es desplegable en Vercel, que no ejecuta Java.

## Contenido

| Archivo | Origen |
|---|---|
| `index.html` | `src/main/webapp/index.jsp` |
| `ciclos.html` | `src/main/webapp/ciclos.jsp` |
| `servicios.html` | `src/main/webapp/servicios.jsp` |
| `assets/bootstrap/` | Bootstrap local |
| `img/` | Solo las 16 imágenes referenciadas por estas páginas |

## Archivos de despliegue

| Archivo | Para qué sirve |
|---|---|
| `vercel.json` | Configuración del proyecto: sitio estático sin build, `cleanUrls`, redirects `*.jsp` → `*.html`, cabeceras de seguridad y caché |
| `.vercelignore` | Excluye del bundle todo lo que no es la landing (`.git`, `tools/`, `*.md`, editores) |
| `404.html` | Página de error servida automáticamente por Vercel; respeta el modo oscuro |
| `robots.txt` | Permite indexación y apunta al sitemap |
| `sitemap.xml` | Las 3 URLs públicas |
| `.gitattributes` | Normaliza saltos de línea a LF (el proyecto se edita en Windows) |
| `.gitignore` | Ignora `node_modules/`, `.vercel`, logs y basura del SO |

### Qué hace `vercel.json`

- **Sin build.** `framework: null`, `buildCommand: null`, `outputDirectory: "."`.
  Vercel sirve la raíz del repo tal cual; no hay `package.json` ni dependencias.
- **`cleanUrls: true`.** `/ciclos.html` redirige (308) a `/ciclos`. Los enlaces
  internos siguen escritos con `.html` y funcionan por ese redirect.
- **Redirects heredados.** Las rutas `*.jsp` del proyecto Java original apuntan a
  su equivalente estático, para no romper enlaces antiguos.
- **Caché.** `img/` y `assets/` son inmutables por 1 año; el HTML se revalida
  siempre, para que un redeploy se vea al instante.
- **Seguridad.** HSTS, `nosniff`, `X-Frame-Options`, `Referrer-Policy`,
  `Permissions-Policy` y una CSP que lista solo los orígenes que la landing usa
  de verdad: Google Fonts, Font Awesome (`kit.` y `ka-f.`), unpkg (AOS) y jsDelivr.

> **Nota sobre la CSP:** incluye `'unsafe-inline'` en `script-src` y `style-src`
> porque las páginas llevan `<style>` y `<script>` embebidos y el hosting estático
> no puede inyectar un nonce por petición. Para endurecerlo habría que extraer ese
> código a archivos propios o añadir un Edge Middleware.

## Diferencias respecto al JSP original

- Las etiquetas `<fmt:message>` se resolvieron contra `src/main/resources/mensajes.properties` (locale `es`).
- Se retiró el enlace **Intranet** (`login.jsp`) del navbar y del footer: no existe en la demo.
- Los CTAs que apuntaban a `preins.jsp` ahora enlazan a la sección `#contacto`.
- Los enlaces internos `*.jsp` se reescribieron a `*.html`.

## Regenerar

La landing no se edita a mano: se genera desde el proyecto Java.

```bash
node tools/build-landing.mjs
```

El script vive en la rama del proyecto completo y escribe en `landing-vercel/`.

## Desarrollo local

Cualquier servidor estático sirve. Con Vercel CLI se respetan `cleanUrls`,
redirects y cabeceras:

```bash
npx vercel dev
```

Alternativa sin instalar nada de Vercel:

```bash
npx serve .
```

## Despliegue

### Primera vez (conectar el repo)

1. En [vercel.com/new](https://vercel.com/new), importa este repositorio.
2. **Framework Preset:** `Other`.
3. **Root Directory:** la raíz del repo.
4. Deja Build Command y Output Directory vacíos — `vercel.json` ya los define.
5. **Production Branch:** la rama que contiene esta landing (no `master` ni `ramahebert`).
6. Deploy.

### Desde la CLI

```bash
npx vercel          # preview
npx vercel --prod   # producción
```

### Después

Cada push a la rama de producción dispara un deploy automático.

### Dominio

`robots.txt` y `sitemap.xml` apuntan a `https://nivela1-page.vercel.app`.
Si conectas un dominio propio, actualiza esa URL en ambos archivos.
