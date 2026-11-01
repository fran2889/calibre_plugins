@echo off
setlocal

rem GNU gettext is required to include TRANSLATORS comments in the catalog.
where xgettext >nul 2>&1
if errorlevel 1 (
    echo GNU gettext's xgettext must be installed and available on PATH.
    exit /b 1
)

pushd "%~dp0.."
if errorlevel 1 exit /b 1
echo Regenerating translations .pot file
(
    echo action.py
    echo config.py
    echo dialogs.py
    for %%f in (..\common\common_*.py) do @echo %%f
) | xgettext --language=Python --from-code=UTF-8 --keyword=_^
 --add-comments=TRANSLATORS: --sort-by-file --no-wrap^
 --package-name="Generate Cover" --output=translations\generate-cover.pot --files-from=-

set "generate_pot_status=%errorlevel%"
popd
exit /b %generate_pot_status%
