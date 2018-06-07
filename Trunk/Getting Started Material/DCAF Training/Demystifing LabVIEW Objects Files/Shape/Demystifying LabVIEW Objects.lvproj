<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="15008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Clusters" Type="Folder">
			<Item Name="Circle Library.lvlib" Type="Library" URL="../../Circle Library.lvlib"/>
			<Item Name="square cluster.ctl" Type="VI" URL="../../square cluster.ctl"/>
			<Item Name="Shape.ctl" Type="VI" URL="../Shape.ctl"/>
			<Item Name="colors.ctl" Type="VI" URL="../../colors.ctl"/>
		</Item>
		<Item Name="Classes" Type="Folder">
			<Item Name="Square.lvclass" Type="LVClass" URL="../../Square/Square.lvclass"/>
			<Item Name="Circle.lvclass" Type="LVClass" URL="../../Circle/Circle.lvclass"/>
			<Item Name="Shape.lvclass" Type="LVClass" URL="../Shape.lvclass"/>
			<Item Name="Solution Triangle.lvclass" Type="LVClass" URL="../../Solution Triangle/Solution Triangle.lvclass"/>
		</Item>
		<Item Name="Demo" Type="Folder">
			<Item Name="Triangle Demo Init.vi" Type="VI" URL="../../Triangle Demo Init.vi"/>
			<Item Name="Triangle Top Level VI.vi" Type="VI" URL="../../Triangle Top Level VI.vi"/>
		</Item>
		<Item Name="Solution" Type="Folder">
			<Item Name="Triangle Demo Init Solution.vi" Type="VI" URL="../../Triangle Demo Init Solution.vi"/>
			<Item Name="Triangle Top Level VI Solution.vi" Type="VI" URL="../../Triangle Top Level VI Solution.vi"/>
		</Item>
		<Item Name="Other" Type="Folder">
			<Item Name="Screen Caps VI.vi" Type="VI" URL="../../Screen Caps VI.vi"/>
			<Item Name="Not in the library.vi" Type="VI" URL="../../Not in the library.vi"/>
			<Item Name="Top Level Vi.vi" Type="VI" URL="../../Top Level Vi.vi"/>
		</Item>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
