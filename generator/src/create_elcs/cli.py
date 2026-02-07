"""
ELCS Project Generator CLI

Usage:
    create-elcs myproject
    create-elcs myproject --path /custom/path
    uvx create-elcs myproject
"""

import os
import shutil
from datetime import datetime
from pathlib import Path

import click
from rich.console import Console
from rich.panel import Panel

console = Console()

# Template directory (relative to this package)
TEMPLATE_DIR = Path(__file__).parent.parent.parent.parent / "template"


def get_template_dir() -> Path:
    """Get the template directory, handling installed package case."""
    # When installed as package, template is in package data
    pkg_template = Path(__file__).parent / "template"
    if pkg_template.exists():
        return pkg_template
    
    # When running from repo
    if TEMPLATE_DIR.exists():
        return TEMPLATE_DIR
    
    raise FileNotFoundError(
        "ELCS template not found. Please reinstall the package."
    )


def replace_placeholders(content: str, project_name: str) -> str:
    """Replace template placeholders with actual values."""
    now = datetime.now().isoformat()
    
    replacements = {
        "{{PROJECT_NAME}}": project_name,
        "{{PROJECT_OBJECTIVE}}": f"Build {project_name}",
        "{{CREATED_DATE}}": now,
    }
    
    for placeholder, value in replacements.items():
        content = content.replace(placeholder, value)
    
    return content


def copy_template(template_dir: Path, target_dir: Path, project_name: str) -> int:
    """Copy template to target directory, replacing placeholders."""
    files_copied = 0
    
    for src_path in template_dir.rglob("*"):
        if src_path.is_file():
            # Calculate relative path
            rel_path = src_path.relative_to(template_dir)
            dest_path = target_dir / rel_path
            
            # Create parent directories
            dest_path.parent.mkdir(parents=True, exist_ok=True)
            
            # Check if it's a text file we should process
            if src_path.suffix in ('.md', '.json', '.txt', '') or src_path.name in ('CLAUDE.md', '.cursorrules', '.windsurfrules'):
                try:
                    content = src_path.read_text(encoding='utf-8')
                    content = replace_placeholders(content, project_name)
                    dest_path.write_text(content, encoding='utf-8')
                except UnicodeDecodeError:
                    # Binary file, just copy
                    shutil.copy2(src_path, dest_path)
            else:
                # Copy as-is
                shutil.copy2(src_path, dest_path)
            
            files_copied += 1
    
    return files_copied


@click.command()
@click.argument("project_name")
@click.option(
    "--path", "-p",
    type=click.Path(),
    default=None,
    help="Parent directory for the project (default: current directory)"
)
@click.option(
    "--quiet", "-q",
    is_flag=True,
    help="Minimal output"
)
def main(project_name: str, path: str | None, quiet: bool):
    """Create a new ELCS project.
    
    Example:
        create-elcs myproject
        create-elcs myproject --path ~/projects
    """
    
    # Determine target directory
    if path:
        parent_dir = Path(path).expanduser().resolve()
    else:
        parent_dir = Path.cwd()
    
    target_dir = parent_dir / project_name
    
    # Check if directory exists
    if target_dir.exists():
        console.print(f"[red]Error:[/red] Directory '{target_dir}' already exists.")
        raise SystemExit(1)
    
    # Get template
    try:
        template_dir = get_template_dir()
    except FileNotFoundError as e:
        console.print(f"[red]Error:[/red] {e}")
        raise SystemExit(1)
    
    if not quiet:
        console.print(Panel.fit(
            f"[bold blue]ELCS Project Generator[/bold blue]\n\n"
            f"Creating: [green]{project_name}[/green]\n"
            f"Location: [dim]{target_dir}[/dim]",
            border_style="blue"
        ))
    
    # Create project
    try:
        target_dir.mkdir(parents=True, exist_ok=True)
        files_copied = copy_template(template_dir, target_dir, project_name)
    except Exception as e:
        console.print(f"[red]Error creating project:[/red] {e}")
        raise SystemExit(1)
    
    if not quiet:
        console.print(f"\n[green]✓[/green] Created {files_copied} files")
        console.print(f"\n[bold]Next steps:[/bold]")
        console.print(f"  1. [cyan]cd {project_name}[/cyan]")
        console.print(f"  2. Open in your AI-assisted IDE or run [cyan]claude[/cyan]")
        console.print(f"  3. Your agent will read ELCS protocol automatically")
        console.print(f"\n[dim]Learn more: elcs/QUICKSTART.md[/dim]")
    else:
        console.print(target_dir)


if __name__ == "__main__":
    main()
