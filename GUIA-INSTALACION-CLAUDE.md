# Guía de instalación: skills globales para Claude Code

Documento para pasarle a Claude Code en otro PC ("sigue esta guía"). Instala 4 herramientas de terceros de forma global y pasiva (que se usen solas, sin comandos), evitando que se pisen con lo ya instalado.

**Estado:** este procedimiento se ejecutó y verificó en el PC original (Windows 11, Claude Code CLI, Git Bash). En un sistema distinto, adaptar las rutas.

## Instrucciones para Claude (leer primero)

1. Antes de instalar, clona cada repo en una carpeta temporal nueva y vacía, haz `git checkout <commit>` del commit revisado y vuelve a revisar hooks, scripts y llamadas de red. Si el repo ha cambiado mucho desde ese commit, avisa al usuario en vez de instalar a ciegas.
2. Instala **solo** lo que indica esta guía. Si algo ya existe en `~/.claude/skills/`, no lo sobrescribas sin preguntar.
3. Haz una copia de seguridad de `~/.claude/CLAUDE.md` antes de modificarlo.
4. Las skills nuevas solo cargan en una sesión nueva. Verifica tras reiniciar.
5. Si el sistema de permisos bloquea instalar un plugin o escribir en `~/.claude`, no lo esquives: explícale al usuario qué intentas y deja que decida.

## Requisitos

- Claude Code (CLI), Node.js 18+, git. Python no es necesario.
- Ya debería estar instalado lo que esta guía da por supuesto: skills `ui-ux-pro-max` y `rams`, plugin `dart-flutter`, plugin `context-mode`.

## Qué se instala y cómo

| Herramienta | Repo | Commit revisado | Forma de instalación |
|---|---|---|---|
| Ponytail | https://github.com/DietrichGebert/ponytail | `9cc65d0` | Plugin (necesita sus hooks) |
| Archify | https://github.com/tt-a1i/archify | `bb990b1` | Solo skill: carpeta `archify/` |
| Impeccable | https://github.com/pbakaus/impeccable | `d631a88` | Solo skill: carpeta `plugin/skills/impeccable/` (sin hooks) |
| Addy Osmani Skills | https://github.com/addyosmani/agent-skills | `1401c8b` | Subconjunto de 13 skills + carpeta `references/` |

### Por qué estas formas de instalación

- **Impeccable sin hooks:** su plugin ejecuta un binario nativo en cada edición y al final de cada turno. El binario no está en el repo (se descarga de GitHub Releases con comprobación sha256), así que no se puede auditar. Como skill solo se ejecuta cuando se usa. Además escribe `PRODUCT.md` y `DESIGN.md` en cada proyecto, por eso la regla de CLAUDE.md pide permiso antes.
- **Addy Osmani en subconjunto:** se excluyen las skills que se pisan con las que ya hay (`code-review-and-quality`, `code-simplification`, `frontend-ui-engineering`, `context-engineering`), las orientadas a web (`performance-optimization`, `browser-testing-with-devtools`) y las que no aportan (`ci-cd-and-automation`, `observability-and-instrumentation`, `deprecation-and-migration`, `doubt-driven-development`, `constraint-driven-development`, `using-agent-skills`). Las 9 slash-commands del plugin tampoco se instalan (se busca uso pasivo).
- **Ponytail:** contradice en dos puntos las reglas del usuario (no crear abstracciones no pedidas; tests solo en lógica no trivial). Se resuelve con la regla de precedencia del paso 3.

### Descartados (no instalar)

- **ADHD** (https://github.com/uditakhourii/adhd): cuesta de 5 a 10 veces una respuesta normal (unas 10 llamadas a subagentes). Se instalaría solo si hay decisiones de arquitectura grandes.
- **watermarks-remover** (https://github.com/guillaumemeyer/watermarks-remover): el plugin lanza Python tras cada escritura de archivo y la otra skill necesita un servicio aparte. Decisión del usuario: no instalar.
- **everything-claude-code** (más de 20 hooks y más de 100 skills por sesión), **Caveman**, **Graphify**, **Understand Anything**, **Superpowers** (se pisa con Addy; elegir uno).

## Pasos

### 1. Ponytail (plugin)

```bash
claude plugin marketplace add DietrichGebert/ponytail
claude plugin install ponytail@ponytail
```

Evita el aviso de statusline que Ponytail inyecta en el primer arranque (crea el fichero marcador vacío):

```bash
: > ~/.claude/.ponytail-statusline-nudged
```

### 2. Skills (copiar desde los clones ya revisados)

`$S` es la carpeta temporal donde clonaste y haces checkout de cada commit.

```bash
D=~/.claude/skills
cp -r "$S/archify/archify"                     "$D/archify"
cp -r "$S/impeccable/plugin/skills/impeccable" "$D/impeccable"
for n in spec-driven-development planning-and-task-breakdown incremental-implementation \
         test-driven-development debugging-and-error-recovery security-and-hardening \
         documentation-and-adrs git-workflow-and-versioning idea-refine interview-me \
         source-driven-development api-and-interface-design shipping-and-launch; do
  cp -r "$S/agent-skills/skills/$n" "$D/$n"
done
cp -r "$S/agent-skills/references" ~/.claude/references   # las skills de Addy lo referencian con ../../references/
```

### 3. Reglas de uso pasivo en `~/.claude/CLAUDE.md`

Añadir este bloque al final (tras la copia de seguridad). Sirve para que Claude use las herramientas solo y para resolver los solapes con las reglas del usuario.

```markdown
<!-- third-party-skills-start -->
## Skills de terceros: uso y precedencia

- Precedencia: este archivo y el CLAUDE.md del proyecto mandan sobre Ponytail y sobre cualquier skill de terceros.
- Ponytail (código mínimo) no anula: un test por cada cambio de comportamiento, extraer a un componente compartido lo que se usa dos veces y respetar el sistema de diseño del proyecto.
- UI Flutter/nativa: `ui-ux-pro-max` y `rams`. UI web (HTML/CSS/JS): `ui-ux-pro-max` para decidir e `impeccable` para criticar, auditar y pulir al terminar cambios de UI. No usar `impeccable` en Flutter. Preguntar antes de que `impeccable` cree `PRODUCT.md` o `DESIGN.md` o descargue su binario.
- Proceso (skills de Addy Osmani): `spec-driven-development` y `planning-and-task-breakdown` en funciones no triviales; `debugging-and-error-recovery` en bugs de causa desconocida; `security-and-hardening` al tocar auth, entradas o secretos; `shipping-and-launch` antes de desplegar; `documentation-and-adrs` en decisiones de arquitectura. No usarlas en ediciones triviales. `git-workflow-and-versioning` nunca añade trailers Co-Authored-By.
- `archify`: usarla sola cuando se pida documentar o visualizar arquitectura, flujos o secuencias.
<!-- third-party-skills-end -->
```

### 4. Verificación (en una sesión nueva)

```bash
claude plugin list          # ponytail@ponytail enabled
ls ~/.claude/skills         # 15 carpetas nuevas (archify, impeccable y 13 de Addy)
```

- En Claude: preguntar qué skills tiene disponibles y comprobar que aparecen las nuevas.
- Medir el coste fijo con `/context` antes y después. Esperable: unos 4-5 mil tokens más por sesión (instrucciones de Ponytail + descripciones de skills).

## Notas de seguridad

- Todo es código de terceros con los permisos del usuario. Los hooks de Ponytail (Node) corren en cada sesión y en cada prompt; leídos y sin llamadas de red.
- Impeccable descargará un binario la primera vez que se use en un proyecto web, desde `github.com/pbakaus/impeccable/releases`.
- Para actualizar: repetir la revisión con los commits nuevos antes de copiar.
