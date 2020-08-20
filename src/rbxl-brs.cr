require "brs-cr"
require "option_parser"
require "xml"

require "./rbxl-brs/cframe.cr"

require "./rbxl-brs/bricks/abstract.cr"
require "./rbxl-brs/bricks/default_brick.cr"
require "./rbxl-brs/bricks/default_ramp.cr"
require "./rbxl-brs/bricks/default_ramp_corner.cr"
require "./rbxl-brs/bricks/default_ramp_corner_inverted.cr"
require "./rbxl-brs/bricks/default_ramp_inner_corner.cr"
require "./rbxl-brs/bricks/default_ramp_inverted.cr"
require "./rbxl-brs/bricks/default_side_wedge.cr"
require "./rbxl-brs/bricks/default_side_wedge_tile.cr"
require "./rbxl-brs/bricks/default_tile.cr"
require "./rbxl-brs/bricks/default_wedge.cr"

include RBXLBRS

in_filename = "in.brs"
out_filename = "out.rbxlx"

OptionParser.parse do |parser|
  parser.banner = "rbxl-brs"

  parser.on "-i PATH", "--input PATH", "Set input location" do |path|
    in_filename = path
  end

  parser.on "-o PATH", "--output PATH", "Set output location" do |path|
    out_filename = path
  end
end

in_file = File.open(in_filename)
in_save = BRS::Save.new(in_file)

out_xml = XML.build(indent: "\t") do |xml|
  xml.element "roblox", {"xmlns:xmine" => "http://www.w3.org/2005/05/xmlmime", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", "xsi:noNamespaceSchemaLocation" => "http://www.roblox.com/roblox.xsd", "version" => "4"} do
    xml.element "Item", {"class" => "Workspace"} do
      in_save.bricks.each do |brick|
        # determine asset name and consequently the Part used to convert to roblox bricks
        asset_name = in_save.brick_assets[brick.asset_name_index]

        case asset_name
        when "PB_DefaultBrick"
          DefaultBrick.new(in_save, brick).write_xml(xml)
        when "PB_DefaultTile"
          DefaultTile.new(in_save, brick).write_xml(xml)
        when "PB_DefaultWedge"
          DefaultWedge.new(in_save, brick).write_xml(xml)
        when "PB_DefaultSideWedge"
          DefaultSideWedge.new(in_save, brick).write_xml(xml)
        when "PB_DefaultSideWedgeTile"
          DefaultSideWedgeTile.new(in_save, brick).write_xml(xml)
        when "PB_DefaultRamp"
          DefaultRamp.new(in_save, brick).write_xml(xml)
        when "PB_DefaultRampInverted"
          DefaultRampInverted.new(in_save, brick).write_xml(xml)
        when "PB_DefaultRampCorner"
          DefaultRampCorner.new(in_save, brick).write_xml(xml)
        when "PB_DefaultRampCornerInverted"
          DefaultRampCornerInverted.new(in_save, brick).write_xml(xml)
        when "PB_DefaultRampInnerCorner"
          DefaultRampInnerCorner.new(in_save, brick).write_xml(xml)
        #when "PB_DefaultRampInnerCornerInverted"
        #  DefaultRampInnerCornerInverted.new(in_save, brick).write_xml(xml)
        else
          # don't do anything, just skip the brick
          puts "skipping brick with asset name \"#{asset_name}\""
        end
      end
    end
  end
end

File.write(out_filename, out_xml)
