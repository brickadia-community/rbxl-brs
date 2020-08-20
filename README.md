# rbxl-brs

rbxl-brs is a tool to convert .BRS (Brickadia saves) to .RBXL(X) (Roblox saves), and eventually vice versa.

### Supported bricks

- [x] PB_DefaultBrick
- [x] PB_DefaultRamp
- [x] PB_DefaultRampInverted
- [x] PB_DefaultRampCorner
- [x] PB_DefaultRampCornerInverted
- [x] PB_DefaultRampInnerCorner
- [ ] PB_DefaultRampInnerCornerInverted
- [ ] PB_DefaultRampCrest
- [ ] PB_DefaultRampCrestCorner
- [ ] PB_DefaultRampCrestEnd
- [ ] some more crest-related bricks
- [x] PB_DefaultSideWedge
- [x] PB_DefaultSideWedgeTile
- [x] PB_DefaultTile
- [x] PB_DefaultWedge
- [ ] all non procedural bricks

### RBXL(X) to BRS

This functionality is planned, but I am currently thinking on how to implement it. Roblox supports parts at arbitrary positions and rotations,
while Brickadia locks everything to a fine grid of tenths of a stud, and rotations currently at quarter circles along the six axes.

## Installation

`git clone https://github.com/voximity/rbxl-brs.git`
`cd rbxl-brs`
`shards install`
`shards build`
`./bin/rbxl-brs -i my_brs_file.brs -o my_rbxlx_file.rbxlx`

Does not compile on Windows (use WSL).

## Contributors

- [voximity](https://github.com/your-github-user) - creator and maintainer
