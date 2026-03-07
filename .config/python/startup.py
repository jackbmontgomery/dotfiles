try:
    import os
    import subprocess

    import matplotlib as mpl
    import matplotlib.pyplot as plt

    def _get_git_root():
        try:
            return (
                subprocess.check_output(
                    ["git", "rev-parse", "--show-toplevel"], stderr=subprocess.DEVNULL
                )
                .decode()
                .strip()
            )
        except subprocess.CalledProcessError:
            return os.path.expanduser("~")

    mpl.rcParams["savefig.directory"] = _get_git_root()

    if not getattr(plt.show, "_patched", False):
        _orig_show = plt.show

        def _show(*args, **kwargs):
            _orig_show(*args, **kwargs)
            subprocess.run(["open", "-a", "WezTerm"])

        _show._patched = True
        plt.show = _show
except ImportError:
    pass
