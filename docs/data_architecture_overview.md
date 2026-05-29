# Data Architecture overwiew

## Overview

This project uses a layered PostgreSQL data architecture. The purpose of this structure is to move data through layers until it becomes clean, trusted and validated with database contrainsts, ready for reporting. 

This is the flow the pipeline follows:

```text
raw -> 