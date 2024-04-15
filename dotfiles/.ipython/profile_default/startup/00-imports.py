from importlib import reload


try:
    import pandas as pd
    import plotly.express as px
    from matplotlib import pyplot as plt
    import numpy as np
    pd.set_option('display.max_rows', 500)
    pd.set_option('display.max_columns', 500)
    pd.set_option('display.width', 1000)
    pd.options.display.float_format = '{:,.4f}'.format
except ModuleNotFoundError:
    pass


if False:
    try:
        import seaborn as sns
    except ModuleNotFoundError:
        pass
